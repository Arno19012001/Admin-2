#!/bin/bash

echo "Waiting for front container to respond..."

# Tentatives de ping jusqu'à ce que le service 'front' réponde
until ping -c1 front >/dev/null 2>&1; do
  echo "front not reachable yet..."
  sleep 2
done

echo "Waiting for api container to respond..."

# Tentatives de ping jusqu'à ce que le service 'api' réponde
until ping -c1 api >/dev/null 2>&1; do
  echo "api not reachable yet..."
  sleep 2
done

echo "front and api are reachable. Starting Nginx..."
exec nginx -g "daemon off;"
