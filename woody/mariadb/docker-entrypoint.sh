#!/bin/sh

# Lire les mots de passe depuis les secrets et les exporter
export MARIADB_ROOT_PASSWORD=$(cat /run/secrets/mariadb_root_password)
export MARIADB_PASSWORD=$(cat /run/secrets/mariadb_user_password)

# Lancer l'entrée principale du conteneur (le vrai MariaDB)
exec docker-entrypoint.sh "$@"
