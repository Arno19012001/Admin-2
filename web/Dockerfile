FROM nginx:stable

RUN rm /etc/nginx/nginx.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html/www
