FROM alpine:3.18

# Install mariadb
RUN apk update && apk upgrade && apk --no-cache add mariadb mariadb-client
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init_db.sh /tmp/init_db.sh

EXPOSE 3306

CMD ["sh", "/tmp/init_db.sh"]