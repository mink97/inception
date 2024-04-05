FROM alpine:3.18

EXPOSE 443

RUN set -eux; \
    deluser xfs 2> /dev/null && \
    delgroup www-data 2> /dev/null && \
    addgroup -g 33 www-data && \
    adduser -s /bin/false -h /var/www -u 33 -G www-data -D www-data
RUN mkdir -p /run/nginx # Create a directory for the pid file

# Install nginx
RUN apk update && apk upgrade && apk --no-cache add nginx openssl dumb-init \
    && rm -rf /var/cache/apk/*

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 -sha256 \
    -keyout /etc/ssl/private/nginx_selfsigned.key \
    -out /etc/ssl/certs/nginx_selfsigned.crt \
    -subj "/C=KO/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=mingkang.42.fr"

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["nginx", "-g", "daemon off;"]
