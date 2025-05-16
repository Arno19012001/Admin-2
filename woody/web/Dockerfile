FROM nginx:stable-alpine

RUN apk update && apk add curl

COPY ./www /var/www/html/www

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
