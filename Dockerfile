FROM nginx

# Remove default configuration files
RUN rm /etc/nginx/conf.d/default.conf

# Install letsencrypt
RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >>/etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y python-setuptools && \
    easy_install j2cli && \
    apt-get -t jessie-backports install -y letsencrypt && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*

COPY ./config /etc/nginx
COPY ./templates /templates
COPY ./docker-entrypoint.sh /

EXPOSE 80 443

CMD ["nginx"]
ENTRYPOINT ["/docker-entrypoint.sh"]
