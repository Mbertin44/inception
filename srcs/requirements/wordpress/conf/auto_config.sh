#!/bin/sh
wp_config_file="/var/www/wordpress/wp-config.php"
php_file="/run/php"

sleep 30

if [ ! -f "$wp_config_file" ]; then
    # --------------------- 1er étape : Configuration de la base de données SQL pour WordPress ---------------------
    echo "Configuration de php"
	wp --allow-root config create \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306" --path='/var/www/wordpress'

    # --------------------- 2eme étape : Création de la page ---------------------
    echo "Création de la page"
    wp --allow-root core install \
        --url='https://mbertin.42.fr' \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path='/var/www/wordpress/'

    # --------------------- 3eme étape : Ajout d'un utilisateur ---------------------
    echo "Création d'un nouvelle utilisateur"
    wp --allow-root user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --path='/var/www/wordpress/'

    if [ ! -d "$php_file" ]; then
        mkdir "$php_file"
    fi
fi

/usr/sbin/php-fpm7.3 -F 