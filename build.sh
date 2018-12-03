#!/bin/bash

#set -e
#set -x

BASE_IMAGE="ruby:2.5"
IMAGE="scolytus/gollum"




TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TAG="SNAPSHOT-${TIMESTAMP}"
FULL="${IMAGE}:${TAG}"
LATEST="${IMAGE}:latest"

docker pull "${BASE_IMAGE}"

docker build -t "${FULL}" .

docker tag "${FULL}" "${LATEST}"

docker push "${FULL}"
docker push "${LATEST}"
