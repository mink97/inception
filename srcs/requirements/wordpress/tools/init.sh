#!/bin/sh
set -e

if [ -f /var/www/html/wp-config.php ]; then
	echo "WordPress already installed"
else
	echo "download wordpress"
	wp core download --path=/var/www/html

	# config 파일 생성
	wp config create --dbname="$MARIADB_DATABASE" \
						--dbuser="$MARIADB_USER" \
						--dbpass="$MARIADB_PASSWORD" \
						--dbhost=mariadb

	# 데이터베이스 있는지 확인
	if ! wp core is-installed 2> /dev/null; then
		wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" \
						--admin_user="$WP_ADMIN" \
						--admin_password="$WP_ADMIN_PASSWORD" \
						--admin_email="$WP_ADMIN_EMAIL"
	fi

	# 유저가 두명인지 확인
	if ! wp user list --field=ID | wc -l | grep 2; then
		wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD"
	fi
	chown -R www-data:www-data /var/www/html
fi

exec "$@"
