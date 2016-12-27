#!/bin/bash -e

# Evaluate configuration
cp -R /templates/* /etc/nginx/
for f in $(find /etc/nginx/ -type f -name "*.j2"); do
    echo -e "Evaluating template\n\tSource: $f\n\tDest: ${f%.j2}"
    j2 $f > ${f%.j2}
    rm -f $f
done

# Ensure LetsEncrypt certificate is up to date
letsencrypt certonly --agree-tos -d ${NGINX_SERVER_NAME} --keep --authenticator standalone --email ${CERTIFICATE_EMAIL}

cd /etc/nginx
echo "nginx container: ${NGINX_SERVER_NAME} (NGINX_SERVER_NAME)"
echo "certificate email: ${CERTIFICATE_EMAIL} (CERTIFICATE_EMAIL)"
echo "executing: $@"
exec "$@"
