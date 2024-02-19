#!/bin/bash

RUNTIME="ctr"

declare -a image_names=(
    "docker.io/library/elasticsearch:8.12.1"
    "docker.io/library/mongo:7.0.5"
    "docker.io/library/postgres:12.18-bullseye"
    "docker.io/library/openjdk:23-slim-bullseye"
    "docker.io/library/node:hydrogen-slim"
)

if [ $# -ge 1 ]; then
    RUNTIME="$1"
fi

if [ "$RUNTIME" == "ctr" ]; then
    echo "RUNTIME is set to cotnainerd"
    for img in "${image_names[@]}"; do
      echo "### Pulling $img ###"
      ctr images pull ${img} | grep "done:"
      ctr images ls | grep ${img} | awk '{print $4 $5}'
      ctr images del ${img} > /dev/null
      echo "####################"
    done
elif [ "$RUNTIME" == "docker" ]; then
    echo "RUNTIME is set to docker"
else
    echo "Unsupported runtime."
    exit 1
fi


