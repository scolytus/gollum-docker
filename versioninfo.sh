#!/bin/bash

# set -e
# set -x

TAG="latest"
[[ -z "${1}" ]] || TAG="${1}"

. ./functions.sh

SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi


VERSION_GEM=$(run gem --version)
VERSION_GOLLUM=$(run gollum --versions)

cat << __HERE__
## ${TAG}

### Gollum Version Info

\`\`\`
${VERSION_GOLLUM}
\`\`\`

### Ruby Gem Version

\`\`\`
${VERSION_GEM}
\`\`\`

__HERE__
