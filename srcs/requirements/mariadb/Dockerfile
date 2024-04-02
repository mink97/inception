FROM alpine:3.18

# Install mariadb
RUN apk update && apk upgrade && apk --no-cache add mariadb mariadb-client
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init_db.sh /tmp/init_db.sh

EXPOSE 3306

CMD ["sh", "/tmp/init_db.sh"]

## test
# FROM debian:buster

# EXPOSE 3306

# RUN apt-get update -y && \
#     apt-get upgrade -y && \
#     apt-get install -y vim dumb-init \
#     mariadb-server \
#     mariadb-client && \
#     rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/run/mysqld
# RUN chown -R mysql:mysql /var/run/mysqld
# RUN chmod 777 /var/run/mysqld

# COPY conf/test.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# COPY ./tools/setup_db.sh /usr/local/bin/

# RUN chmod +x /usr/local/bin/setup_db.sh

# ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/setup_db.sh" ]

# CMD [ "mysqld", "--bind-address=0.0.0.0" ]