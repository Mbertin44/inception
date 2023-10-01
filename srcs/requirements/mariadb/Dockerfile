FROM debian:buster

# ---------------------- # Étape 1 : Installation des dépendances de base ----------------------
RUN apt update -y \
    && apt upgrade -y \
    && apt-get install mariadb-server -y

# ------------------------------- # Étape 2 : Modification du fichier de configuration -------------------------------
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# ------------------------------- # Étape 3 : Création de la base de donnée -------------------------------
RUN mysqld \
    # Je laisse le temps a mysql de ce lancer 
    && mysql --wait -e "\
    # Je crée la base de donnée
	CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`; \
    # Je créé un utilisateur
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';\
    # J'accorde les privilèges à l'utilisateur
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}'; \
    # Je modifie le mot de passe root
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';\
    # Je recharge les privilèges d'utilisateur pour appliquer immédiatement les modifications
    FLUSH PRIVILEGES;"\
    # J'arrête le service MySQL
    && mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown\
    # J'attend que le serveur MySQL soit prêt
    && mysql --wait \
    # J'exécute le serveur MySQL en arrière-plan (pas sur que ca soit nécéssaire)
    && exec mysqld_safe 