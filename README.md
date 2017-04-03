# Generate keys and certificates

## Generate Certificate Authority (CA) key and certificate

### Generate CA key and certificate
> openssl req -x509 -newkey rsa:2048 -keyout ca.key -out ca.crt -days 3650

## Generate server key and certificate
### Generate server key and certificate signing request
> openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr -days 3650


## Sign server request
> openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650 -sha256

## Generate client key and certificate
### Generate server key and certificate signing request
> openssl req -new -newkey rsa:2048 -nodes -keyout client.key -out client.csr -days 3650


## Sign server request
> openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 3650 -sha256

## Generate DH param
> openssl dhparam -out dhparam.pem 2048
