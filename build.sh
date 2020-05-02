#!/bin/bash

#set -e
#set -x

BASE_IMAGE="ruby:2.7"
IMAGE="scolytus/gollum"

. ./functions.sh

SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi


TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TAG="BUILD-${TIMESTAMP}"
FULL="${IMAGE}:${TAG}"
LATEST="${IMAGE}:latest"

$SUDO docker pull "${BASE_IMAGE}"

$SUDO docker build --build-arg "BASE_IMAGE=${BASE_IMAGE}" -t "${FULL}" .

VERSION_GOLLUM=$(run gollum --version | grep -o "[0-9\.]*")
MAJOR="${VERSION_GOLLUM:0:1}"
MINOR="$(echo "${VERSION_GOLLUM}" | grep -o -P "^\d\.\d*")"

$SUDO docker tag "${FULL}" "${LATEST}"

[[ -z "${MAJOR}" ]]          || $SUDO docker tag "${FULL}" "${IMAGE}:${MAJOR}"
[[ -z "${MINOR}" ]]          || $SUDO docker tag "${FULL}" "${IMAGE}:${MINOR}"
[[ -z "${VERSION_GOLLUM}" ]] || $SUDO docker tag "${FULL}" "${IMAGE}:${VERSION_GOLLUM}"

$SUDO docker push "${FULL}"
$SUDO docker push "${LATEST}"

[[ -z "${MAJOR}" ]]          || $SUDO docker push "${IMAGE}:${MAJOR}"
[[ -z "${MINOR}" ]]          || $SUDO docker push "${IMAGE}:${MINOR}"
[[ -z "${VERSION_GOLLUM}" ]] || $SUDO docker push "${IMAGE}:${VERSION_GOLLUM}"
