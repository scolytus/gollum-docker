
run() {
  $SUDO docker run --rm --entrypoint="" scolytus/gollum:"${TAG}" "$@"
}
