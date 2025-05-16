#!/bin/sh

# Lire le mot de passe depuis le secret
export MARIADB_PASSWORD=$(cat /run/secrets/mariadb_user_password)

# Chemin du fichier de configuration PHP-FPM
CUSTOM_CONF="/usr/local/etc/php-fpm.d/zzz-custom.conf"

# Créer une configuration personnalisée pour le pool www
cat <<EOF > "$CUSTOM_CONF"
[www]
pm = dynamic
pm.start_servers = 2
pm.min_spare_servers = 2
pm.max_spare_servers = 4
pm.max_children = 10
EOF

# Lancer le processus principal du conteneur
exec "$@"
