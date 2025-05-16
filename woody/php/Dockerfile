FROM php:8.3-fpm-alpine

RUN docker-php-ext-install mysqli
RUN apk update && apk add netcat-openbsd

COPY ./*.php /var/www/html/www/

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
