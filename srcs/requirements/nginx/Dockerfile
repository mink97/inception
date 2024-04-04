FROM alpine:3.18

# Install nginx
RUN apk update && apk upgrade && apk --no-cache add nginx openssl \
	&& rm -rf /var/cache/apk/*

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -sha256 \
	-keyout /etc/ssl/private/nginx_selfsigned.key \
	-out /etc/ssl/certs/nginx_selfsigned.crt \
	-subj "/C=KO/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=mingkang.42.fr"

RUN mkdir -p /run/nginx # Create a directory for the pid file

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
