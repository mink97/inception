FROM alpine:3.18

EXPOSE 9000

RUN apk update && apk upgrade && \
    apk add --no-cache \
    curl \
    php81 \
    php81-phar \
    php81-fpm \
    php81-mysqli \
    php81-cli \
    php81-pdo \
    php81-gd \
    php81-mbstring \
    wget && \
    rm -rf /var/cache/apk/*

# ensure www-data user exists
RUN set -eux; \
    adduser -u 82 -D -S -G www-data www-data

COPY ./conf/www.conf /etc/php81/php-fpm.d/
COPY ./tools/init.sh /usr/local/bin/

# install wp-cli
# 파일을 링크를 통해 다운받을까 아니면 프로그램을 그냥 저장해놓을까
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

RUN chmod +x /usr/local/bin/init.sh

RUN mkdir /run/php

WORKDIR /var/www/html/

ENTRYPOINT [ "init.sh" ]

CMD [ "php-fpm81", "-F", "-R" ]