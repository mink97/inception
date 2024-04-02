#!/bin/bash

# /var/lib/mysql/mysql 여부 확인
if [ ! -d /var/lib/mysql/mysql ];
then
    # /var/lib/mysql/mysql 디렉토리가 없으면
    # mysql_install_db 실행
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null
fi
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ];
then
    # /var/lib/mysql/$MARIADB_DATABASE 디렉토리가 없으면
    # /tmp/init.sql 파일 생성
    >/tmp/init.sql cat <<EOF
    USE mysql;
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;
    CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
    GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
    FLUSH PRIVILEGES;
EOF
    mariadbd --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/init.sql
fi
mariadbd --user=mysql