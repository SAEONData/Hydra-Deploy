#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "Loading environment variables..."
source .env

echo "Running SQL migrations..."
docker run -it --rm "${HYDRA_IMAGE}" migrate sql --yes \
    "postgres://hydra_user:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/hydra_db"

echo "Done."
