#!/bin/bash

SERVER_NAME="$1"
CERT_EMAIL="$2"
test -z "${CERT_EMAIL}" && {
	echo "usage: $0 SERVERNAME CERTEMAIL"
	exit 1
}

SSL_NGINX_IMAGE="$(docker images | grep ssl-nginx | awk '{print $1}')"
test -z "${SSL_NGINX_IMAGE}" && {
	echo "error: 'ssl-nginx' Docker image not found, build it first."
	exit 1
}

echo "Starting Docker container for ${SERVER_NAME}..."
docker run -e NGINX_SERVER_NAME="${SERVER_NAME}" \
           -e CERTIFICATE_EMAIL="${CERT_EMAIL}" \
           -e TERM=xterm \
           -p 80:80 \
           -p 443:443 \
           -v /volumes/web:/web \
           -d \
           ssl-nginx
echo "Done."
