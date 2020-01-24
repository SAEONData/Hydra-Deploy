#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "Loading environment variables..."
source .env

echo "Creating network..."
docker network create hydra-net

echo "Creating data volume..."
docker volume create hydra-data

echo "Starting the Hydra DB container..."
docker run -d --name hydra-db --network hydra-net --volume hydra-data:/var/lib/postgresql/data \
    -e PGDATA=/var/lib/postgresql/data \
    -e POSTGRES_DB="${POSTGRES_DB}" \
    -e POSTGRES_USER="${POSTGRES_USER}" \
    -e POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
    postgres:9.6

echo "Running SQL migrations..."
docker run -it --rm --network hydra-net oryd/hydra:v1.2.1 migrate sql --yes \
    "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@hydra-db:5432/${POSTGRES_DB}?sslmode=disable"

echo "Deleting the Hydra DB container..."
docker rm -f hydra-db

echo "Done."