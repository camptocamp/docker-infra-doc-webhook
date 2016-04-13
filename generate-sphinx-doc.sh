#!/bin/sh

cd /var/lib/git/sphinx-doc

if ! git config remote.origin.url &> /dev/null; then
  git remote add origin $1
fi
git fetch
git checkout -f $2

infra-doc && make clean-html && make html
