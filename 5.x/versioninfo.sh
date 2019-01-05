#!/bin/bash

# set -e
# set -x

TAG="5-latest"
[[ -z "${1}" ]] || TAG="${1}"

run() {
  docker run --rm --entrypoint="" scolytus/gollum:"${TAG}" "$@"
}

VERSION_GEM=$(run gem --version)
VERSION_GOLLUM=$(run gollum --versions)
VERSION_GIT_LIB=$(run cat /gollum-lib.git.txt)
VERSION_GIT_GOLLUM=$(run cat /gollum.git.txt)

cat << __HERE__
## ${TAG}

### Gollum Version Info

\`\`\`
${VERSION_GOLLUM}
\`\`\`


### Commit IDs

\`\`\`
Gollum:     ${VERSION_GIT_GOLLUM}
Gollum-Lib: ${VERSION_GIT_LIB}
\`\`\`

### Ruby Gem Version

\`\`\`
${VERSION_GEM}
\`\`\`

__HERE__

