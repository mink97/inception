#!/bin/bash

# MariaDB default directory 확인
if [ ! -d /var/lib/mysql/mysql ]; then
	# MariaDB 초기화
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null
fi
# 데이터베이스 존재하는지 확인
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	# /tmp/init.sql 파일을 이용하여 데이터베이스 생성
	>/tmp/init.sql cat <<EOF
	USE mysql;
	FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;
	CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
	FLUSH PRIVILEGES;
EOF
	# 데이터베이스 생성
	mariadbd --user=mysql --bootstrap < tmp/init.sql
	rm -f /tmp/init.sql
fi
# MariaDB 실행
mariadbd --user=mysql
