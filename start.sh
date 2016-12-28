#!/bin/bash

HOST_WEB_PATH="/volumes/web"
HOST_SSL_PATH="/etc/letsencrypt"

[ -f "${HOST_WEB_PATH}/config/nginx.conf" ] || {
    echo "error: ${HOST_WEB_PATH}/config/nginx.conf does not exist." >&2
    exit 1
}

[ -d "${HOST_SSL_PATH}" ] || {
    echo "error: ${HOST_SSL_PATH} does not exist, or is not readable" >&2
    exit 1
}

SSL_NGINX_IMAGE="$(docker images | grep ssl-nginx | awk '{print $1}')"
[ -z "${SSL_NGINX_IMAGE}" ] && {
    echo "error: 'ssl-nginx' Docker image not found, build it first." >&2
    exit 1
}

echo "Starting Docker container for nginx"
echo "  * Host Web Path:           ${HOST_WEB_PATH}"
echo "  * SSL Certificates & Keys: ${HOST_SSL_PATH}"
docker run -p 80:80 \
           -p 443:443 \
           -v ${HOST_WEB_PATH}:/web \
           -v ${HOST_SSL_PATH}:/ssl \
           -d \
           --restart always \
           ssl-nginx
echo "Done."
