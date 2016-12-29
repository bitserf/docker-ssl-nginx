FROM nginx:alpine
RUN rm -rf /etc/nginx
EXPOSE 80 443
ENTRYPOINT ["nginx", "-c", "/web/config/nginx.conf"]
