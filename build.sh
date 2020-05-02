#!/bin/bash

set -e
#set -x

# ---------------------------------------------------------------------------------------------------------------------
# config

BASE_IMAGE="ruby:2.7"
IMAGE="scolytus/gollum"

# ---------------------------------------------------------------------------------------------------------------------
# includes

. ./functions.sh

SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi

# ---------------------------------------------------------------------------------------------------------------------
# variables

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TAG="BUILD-${TIMESTAMP}"
FULL="${IMAGE}:${TAG}"
LATEST="${IMAGE}:latest"

# ---------------------------------------------------------------------------------------------------------------------
# pull

$SUDO docker pull "${BASE_IMAGE}"

# ---------------------------------------------------------------------------------------------------------------------
# build

$SUDO docker build --build-arg "BASE_IMAGE=${BASE_IMAGE}" -t "${FULL}" .

# ---------------------------------------------------------------------------------------------------------------------
# run basic test

CONTAINER="$(createTestContainerName)"
runTestContainer "${CONTAINER}" "${TAG}"

curl "http://127.0.0.1:3080/"

$SUDO docker stop "${CONTAINER}"

# ---------------------------------------------------------------------------------------------------------------------
# tag everything

VERSION_GOLLUM=$(run gollum --version | grep -o "[0-9\.]*")
MAJOR="${VERSION_GOLLUM:0:1}"
MINOR="$(echo "${VERSION_GOLLUM}" | grep -o -P "^\d\.\d*")"

$SUDO docker tag "${FULL}" "${LATEST}"

[[ -z "${MAJOR}" ]]          || $SUDO docker tag "${FULL}" "${IMAGE}:${MAJOR}"
[[ -z "${MINOR}" ]]          || $SUDO docker tag "${FULL}" "${IMAGE}:${MINOR}"
[[ -z "${VERSION_GOLLUM}" ]] || $SUDO docker tag "${FULL}" "${IMAGE}:${VERSION_GOLLUM}"

# ---------------------------------------------------------------------------------------------------------------------
# push everything

$SUDO docker push "${FULL}"
$SUDO docker push "${LATEST}"

[[ -z "${MAJOR}" ]]          || $SUDO docker push "${IMAGE}:${MAJOR}"
[[ -z "${MINOR}" ]]          || $SUDO docker push "${IMAGE}:${MINOR}"
[[ -z "${VERSION_GOLLUM}" ]] || $SUDO docker push "${IMAGE}:${VERSION_GOLLUM}"
