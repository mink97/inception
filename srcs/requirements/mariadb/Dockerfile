FROM alpine:3.18

# Install mariadb
RUN apk update && apk upgrade && apk --no-cache add mariadb mariadb-client dumb-init && \
    rm -rf /var/cache/apk/*
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init_db.sh /tmp/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["sh", "/tmp/init_db.sh"]
