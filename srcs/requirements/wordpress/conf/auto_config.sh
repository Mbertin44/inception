#!/bin/sh
wp_config_file="/var/www/wordpress/wp-config.php"

echo "Debut du sleep"
sleep 30
echo "Fin du sleep"

if [ -f "$wp_config_file" ]; then
    echo "Suppression du fichier wp-config.php"
    rm -rf $wp_config_file
fi

if [ ! -f "$wp_config_file" ]; then
    # --------------------- 1er étape : Configuration de la base de données SQL pour WordPress ---------------------
    echo "Configuration de php"
    # wp --allow-root config create \
    /usr/local/bin/wp-cli.phar --allow-root config create \
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
fi

echo "Execution de php-fpm"
/usr/sbin/php-fpm7.3 -F 

