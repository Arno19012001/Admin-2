#!/bin/bash

set -e

repo="clemoudo/admin2"

# Fonction pour trouver la dernière version utilisée pour une image
get_latest_version() {
  image=$1
  tags=$(curl -s "https://hub.docker.com/v2/repositories/$repo/tags/?page_size=100" | jq -r '.results[].name' | grep "stack-$image-" | sed "s/stack-$image-//" | grep -E '^[0-9]+$' | sort -nr)
  latest=$(echo "$tags" | head -n 1)
  echo "${latest:-0}"
}

# Récupère la dernière version et incrémente
latest_version=$(get_latest_version "api")
version=$((latest_version + 1))

echo "📦 Building version: $version"

# Build et tag les images
docker build -t $repo:stack-api-$version api
docker tag $repo:stack-api-$version $repo:stack-api-latest

docker build -t $repo:stack-reverse_proxy-$version reverse-proxy
docker tag $repo:stack-reverse_proxy-$version $repo:stack-reverse_proxy-latest

docker build -t $repo:stack-database-$version database
docker tag $repo:stack-database-$version $repo:stack-database-latest

docker build -t $repo:stack-front-$version front
docker tag $repo:stack-front-$version $repo:stack-front-latest

# Push des images
docker push $repo:stack-api-$version
docker push $repo:stack-api-latest

docker push $repo:stack-reverse_proxy-$version
docker push $repo:stack-reverse_proxy-latest

docker push $repo:stack-database-$version
docker push $repo:stack-database-latest

docker push $repo:stack-front-$version
docker push $repo:stack-front-latest

echo "✅ Version $version pushed for all services"
