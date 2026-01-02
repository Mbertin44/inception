# Inception

## Présentation

**Inception** est un projet scolaire réalisé dans le cadre du cursus 42, visant à découvrir et maîtriser les concepts fondamentaux de la virtualisation et du déploiement d’infrastructures grâce à Docker. À travers ce projet, l’objectif est de concevoir, configurer et orchestrer une stack de services conteneurisés pour reproduire une petite infrastructure système modulable, sécurisée et automatisée.

---

## Objectif du projet

L'objectif principal du projet **Inception** est de construire, via l’utilisation de Docker, une infrastructure complète capable d’héberger plusieurs services essentiels à toute application web. 
Le projet sert d’introduction pratique à des concepts DevOps clés, tels que :
- La définition d’environnements immuables
- L’automatisation du déploiement de services
- La gestion de la persistance et des volumes
- La sécurité réseau entre les conteneurs

---

## Fonctionnement général

Le projet repose sur la création de plusieurs conteneurs Docker indépendants, chacun étant responsable d’un service spécifique. Ces conteneurs communiquent entre eux à l’aide d’un réseau Docker privé, permettant de sécuriser les échanges et segmenter les rôles.

Le projet demande généralement de mettre en œuvre :

- **Un serveur web (Nginx)** : pour servir le site via HTTPS avec un certificat autosigné et gérer les requêtes HTTP/HTTPS.
- **Un gestionnaire de site dynamique (WordPress)** : installé et configuré automatiquement pour fonctionner avec la base de données.
- **Une base de données relationnelle (MariaDB ou MySQL)** : pour stocker et gérer les données du site WordPress.
- **Volumes Docker** : pour assurer la persistance des données (base de données, fichiers WordPress) même après redémarrage des conteneurs.
- **Un réseau Docker personnalisé** : garantissant l’isolation et la sécurité de l’infrastructure.

Il est également possible d’ajouter d’autres services ou composants (FTP, outil d’administration de la BDD, monitoring, etc.) selon les exigences du sujet.

---

## Outils et technologies utilisés

- **Docker** : Conteneurisation et orchestration des services.
- **Docker Compose** (si autorisé) : Définition et gestion multi-conteneurs de l’infrastructure.
- **Nginx** : Serveur web proxy & reverse proxy HTTP/HTTPS.
- **WordPress** : CMS PHP pour le site dynamique.
- **MariaDB/MySQL** : Gestion de la base de données SQL.
- **OpenSSL** : Génération du certificat SSL.
- **Shell script (bash)** : Automatisation des installations et configurations.
- **Volumes Docker** : Persistance des données.

---

## Structure du projet

Exemple d’arborescence :
```
.
├── srcs/
│   ├── docker-compose.yml       # (Si utilisé)
│   ├── requirements/
│   │   ├── nginx/
│   │   │   └── Dockerfile
│   │   ├── wordpress/
│   │   │   └── Dockerfile
│   │   └── mariadb/
│   │       └── Dockerfile
│   └── scripts/
│       └── ... (install, configure, etc.)
└── README.md
```

---

## Comment déployer le projet ?

1. **Cloner le dépôt :**
   ```bash
   git clone https://github.com/Mbertin44/inception.git
   cd inception
   ```

2. **Configurer les fichiers d’environnement :**
   Adapter les variables d’environnement (`.env`) et/ou les scripts pour définir les paramètres souhaités (mot de passe BDD, nom du site WordPress, etc.)

3. **Lancer la construction des images et le déploiement des services :**
   ```bash
   docker-compose up --build
   ```
   (Ou suivre la procédure spécifique définie dans le projet)

4. **Accéder aux services :**
   - WordPress : `https://localhost` ou l’IP/VHost défini en HTTPS.
   - Base de données : accessible en interne seulement.

---

## Points d’attention

- Chaque service possède un Dockerfile adapté, évitant d’utiliser des images prêtes à l’emploi non autorisées.
- Les mots de passe et secrets doivent être correctement gérés pour éviter toute fuite.
- Les certificats SSL/TLS sont générés dynamiquement à chaque build.
- Il est indispensable de bien nettoyer les ressources Docker en fin de projet pour éviter tout encombrement ou conflit.

