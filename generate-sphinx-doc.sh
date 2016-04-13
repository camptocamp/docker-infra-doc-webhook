#!/bin/sh

cd /var/lib/git/sphinxdoc

if ! git config remote.origin.url &> /dev/null; then
  git remote add origin $1
fi
git fetch
git checkout -f $2

export BUILDHTMLDIR=/sphinxdoc
infra-doc && make clean-html && make html
