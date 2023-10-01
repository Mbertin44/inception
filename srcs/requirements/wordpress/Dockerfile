FROM debian:buster

# ---------------------- # Étape 1 : Installation des dépendances de base ----------------------
RUN apt update -y \
    && apt upgrade -y \
    && apt-get -y install \
        wget\
        #derniere version pour debian buster
        php7.3\
        php-fpm\
        php-mysql\
        mariadb-client

# ---------------------- # Étape 2 : Installation de wordpress ----------------------
RUN wget https://fr.wordpress.org/wordpress-6.3.1-fr_FR.tar.gz -P /var/www \
    && cd /var/www\
    && tar -xzf wordpress-6.3.1-fr_FR.tar.gz\
    && rm wordpress-6.3.1-fr_FR.tar.gz\
    && chown -R root:root /var/www/wordpress\