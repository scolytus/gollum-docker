#!/bin/bash

#set -e
#set -x

BASE_IMAGE="ruby:2.5"
IMAGE="scolytus/gollum"




TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TAG="SNAPSHOT-5-${TIMESTAMP}"
FULL="${IMAGE}:${TAG}"
LATEST="${IMAGE}:5-latest"

docker pull "${BASE_IMAGE}"

docker build -t "${FULL}" .

docker tag "${FULL}" "${LATEST}"

docker push "${FULL}"
docker push "${LATEST}"

