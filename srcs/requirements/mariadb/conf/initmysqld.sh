#!/bin/sh

mysqld & 
# Je laisse le temps a mysql de ce lancer 
# Je crée la base de donnée
mysql --wait -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" 
# Je créé un utilisateur
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# J'accorde les privilèges à l'utilisateur
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" 
# Je modifie le mot de passe root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# #e recharge les privilèges d'utilisateur pour appliquer immédiatement les modifications
mysql -e "FLUSH PRIVILEGES;"
# J'arrête le service MySQL
mysqladmin -u root -p$SQL_ROOT_PASSWORD -S /var/run/mysqld/mysqld.sock shutdown
# J'attend que le serveur MySQL soit prêt
mysql --wait
# J'exécute le serveur MySQL en arrière-plan (pas sur que ca soit nécéssaire)
exec mysqld_safe 