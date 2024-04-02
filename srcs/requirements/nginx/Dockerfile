FROM alpine:3.18

RUN apk update && apk upgrade && apk --no-cache add nginx openssl

RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:4096  -sha256 -keyout /etc/nginx/ssl/nginx_selfsigned.key \
    -out /etc/nginx/ssl/nginx_selfsigned.crt \
    -subj "/C=KO/ST=SEOUL/O=42SEOUL/CN=mingkang"

RUN mkdir -p /run/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
