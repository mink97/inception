FROM alpine:3.18

EXPOSE 9000

RUN set -eux; \
    deluser xfs 2> /dev/null && \
    delgroup www-data 2> /dev/null && \
    addgroup -g 33 www-data && \
    adduser -s /bin/false -h /var/www -u 33 -G www-data -D www-data
RUN mkdir -p /run/php

RUN apk update && apk upgrade && \
    apk add --no-cache \
    dumb-init \
    curl \
    php81 \
    php81-phar \
    php81-fpm \
    php81-mysqli \
    php81-cli \
    php81-pdo \
    php81-gd \
    php81-mbstring \
    php81-json \
    wget && \
    rm -rf /var/cache/apk/*

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY ./tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/

ENTRYPOINT [ "/usr/bin/dumb-init","--", "init.sh" ]

CMD [ "php-fpm81", "-F" ]
