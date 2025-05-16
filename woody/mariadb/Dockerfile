FROM mariadb:11.1

# Copie du script SQL dans le dossier d'initialisation automatique
COPY woodytoys.sql /docker-entrypoint-initdb.d/

# Copie de la configuration personnalisée
COPY my-resolve.cnf /etc/mysql/conf.d/

COPY docker-entrypoint.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

# Utiliser notre entrypoint
ENTRYPOINT ["/entrypoint-wrapper.sh"]

CMD ["mariadbd"]
