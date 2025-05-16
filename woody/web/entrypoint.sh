#!/bin/sh

echo "Waiting for php container to respond..."

# Tentatives de ping jusqu'à ce que le service 'php' réponde
until ping -c1 php >/dev/null 2>&1; do
  echo "php not reachable yet..."
  sleep 2
done

echo "php is reachable. Starting Nginx..."
exec nginx -g "daemon off;"
