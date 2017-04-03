# TODO: Create CA certificate

# Original credit: https://github.com/kylemanna/docker-openvpn & https://github.com/jpetazzo/dockvpn

FROM alpine:3.5

MAINTAINER Jeroen van den Heuvel <jeroen.van.den.heuvel@werkspot.nl>

RUN apk add --no-cache --update openvpn openvpn-doc iptables bash easy-rsa

RUN cp /usr/share/doc/openvpn/samples/sample-config-files/server.conf /etc/openvpn/server.conf && \
    sed -i 's/;user nobody/user nobody/g' /etc/openvpn/server.conf && \
    sed -i 's/;group nobody/group nobody/g' /etc/openvpn/server.conf && \
    sed -i '/^cipher /a auth SHA256' /etc/openvpn/server.conf && \
    sed -i 's/^explicit-exit-notify 1/;explicit-exit-notify 1/g' /etc/openvpn/server.conf

ADD pki/ca.crt /etc/openvpn/ca.crt
ADD pki/server.crt /etc/openvpn/server.crt
ADD pki/server.key /etc/openvpn/server.key
ADD pki/dh.pem /etc/openvpn/dh2048.pem

RUN chmod 0600 /etc/openvpn/*.key

EXPOSE 1194/udp

WORKDIR /etc/openvpn

CMD ["openvpn", "server.conf"]


#&& \    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin
#
## Needed by scripts
#ENV OPENVPN /etc/openvpn
#ENV EASYRSA /usr/share/easy-rsa
#ENV EASYRSA_PKI $OPENVPN/pki
#ENV EASYRSA_VARS_FILE $OPENVPN/vars
#
#ADD ./bin /usr/local/bin
#RUN chmod a+x /usr/local/bin/*
