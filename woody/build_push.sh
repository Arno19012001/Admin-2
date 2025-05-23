#!/bin/bash

set -e

# Résout le chemin absolu du dossier où se trouve ce script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

repo="clemoudo/admin2"

# Fonction pour trouver la dernière version utilisée pour une image
get_latest_version() {
  image=$1
  tags=$(curl -s "https://hub.docker.com/v2/repositories/$repo/tags/?page_size=100" \
    | jq -r '.results[].name' \
    | grep "^$image-" \
    | sed "s/^$image-//" \
    | grep -E '^[0-9]+$' \
    | sort -nr)
  latest=$(echo "$tags" | head -n 1)
  echo "${latest:-0}"
}

# Récupère la dernière version de l'image "web" et incrémente
latest_version=$(get_latest_version "web")
version=$((latest_version + 1))

echo "📦 Building version: $version"

# Build, tag et push pour chaque image
for image in web php mariadb; do
  build_path="$SCRIPT_DIR/$image"
  echo "🔧 Building image: $image from $build_path"
  docker build -t $repo:$image-$version "$build_path"
  docker tag $repo:$image-$version $repo:$image-latest

  echo "📤 Pushing image: $image"
  docker push $repo:$image-$version
  docker push $repo:$image-latest
done

echo "✅ Version $version pushed for all services"

