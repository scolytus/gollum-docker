#!/bin/bash

set -e
set -x

SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi

TAG="latest"
HOST_PORT="127.0.0.1:3080"
BASE="http://${HOST_PORT}"
TEST_WIKI="./test-wiki"
CONTAINER="gollum-test-$(date +%Y%m%d%H%M%S)"

$SUDO docker run \
        -d \
        --rm \
        --name "${CONTAINER}" \
        -v "$(pwd)/${TEST_WIKI}:/wiki" \
        -p "${HOST_PORT}:8080" \
        "scolytus/gollum:${TAG}" \
        --port 8080 \
        --emoji

sleep 2
while ! curl "${BASE}/"; do sleep 2; done

curl "${BASE}/" > /dev/null
curl "${BASE}/Page1.md" > /dev/null
curl "${BASE}/Page1" > /dev/null
curl "${BASE}/gollum/search?q=test" > /dev/null
curl "${BASE}/gollum/search?q=foo" > /dev/null
curl "${BASE}/Page1_9" > /dev/null
curl "${BASE}/large.bin" > /dev/null

#$SUDO docker stop "${CONTAINER}"
