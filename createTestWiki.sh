#!/bin/bash

set -e
# set -x

TEST_WIKI="./test-wiki"

if [[ -d "${TEST_WIKI}" ]]; then
  echo "Directory exists - exit"
  exit -1
fi

mkdir "${TEST_WIKI}"

pushd "${TEST_WIKI}" 2>&1 > /dev/null

git init .

cat > Home.md << __HERE__
# HOME

This is home!
__HERE__

git add Home.md
git commit -m "add Home"

cat > Page1.md << __HERE__
# Page 1

* some content
* lorem ipsum

## Foo

* bar
* baz
__HERE__

git add Page1.md
git commit -m "add Page 1"

cp Page1.md Page2.md

git add Page2.md
git commit -m "add Page 2"

for i in $(seq 1 10); do cp Page1.md Page1_$i.md; done
git add *.md
git commit -m "add more pages"

for i in $(seq 1 200); do head -c 64 /dev/urandom | md5sum >> large.bin; done
dd if=/dev/urandom bs=4M count=5 >> large.bin
git add large.bin
git commit -m "add large binary"

popd 2>&1 > /dev/null
