#!/bin/sh
set -e

if [ -f ./wp-config.php ]
then
    echo "wordpress is already exist"
else # wordpress가 없으면
    echo "download wordpress"
    wp core download --path=/var/www/html
    chown -R www-data:www-data /var/www/html

    # config 파일 생성
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root # allow-root 확인

    # 데이터베이스 있는지 확인
    if ! wp core is-installed --allow-root 2>/dev/null
    then
        echo "installing wordpress..."
        wp core install --url=$DOMAIN_NAME --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --title="$WP_TITLE" --allow-root        
    fi
    # 유저가 두명인지 확인
    if ! wp user list --field=ID --allow-root | wc -l | grep 2
    then
        wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root
    fi
fi

exec "$@"