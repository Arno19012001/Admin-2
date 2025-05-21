FROM nginx:stable-alpine

RUN apk update && apk add curl

COPY ./index.html /usr/share/nginx/html/
COPY ./5mo.jpg /usr/share/nginx/html/
