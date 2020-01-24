#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "!!! DANGER !!!"
echo "This script will delete all Hydra containers and data!"
read -p "Are you sure you want to proceed? [yes|NO] " proceed
[[ $proceed != yes ]] && echo "Aborting" && exit

echo "Deleting Hydra containers..."
sudo docker rm -f hydra hydra-db

echo "Deleting Hydra data volume..."
sudo docker volume rm hydra-data

echo "Deleting Hydra network..."
sudo docker network rm hydra-net

echo "Done."
