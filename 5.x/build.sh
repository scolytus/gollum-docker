#!/bin/bash

#set -e
#set -x

BASE_IMAGE="ruby:2.6"
IMAGE="scolytus/gollum"


SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi


TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TAG="SNAPSHOT-5-26-${TIMESTAMP}"
FULL="${IMAGE}:${TAG}"
LATEST="${IMAGE}:5-latest"

$SUDO docker pull "${BASE_IMAGE}"

$SUDO docker build -t "${FULL}" .

exit -1

$SUDO docker tag "${FULL}" "${LATEST}"

$SUDO docker push "${FULL}"
$SUDO docker push "${LATEST}"

