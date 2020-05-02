#!/bin/bash

set -e
set -x

. ./functions.sh

SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi

TAG="latest"
HOST_PORT="127.0.0.1:3080"
BASE="http://${HOST_PORT}"
TEST_WIKI="./test-wiki"
CONTAINER="$(createTestContainerName)"

runTestContainer "${CONTAINER}" "${TAG}"

sleep 2
while ! curl "${BASE}/"; do sleep 2; done

curl "${BASE}/" > /dev/null
curl "${BASE}/Page1.md" > /dev/null
curl "${BASE}/Page1" > /dev/null
curl "${BASE}/gollum/search?q=test" > /dev/null
curl "${BASE}/gollum/search?q=foo" > /dev/null
curl "${BASE}/Page1_9" > /dev/null
curl "${BASE}/large.bin" > /dev/null

$SUDO docker stop "${CONTAINER}"
