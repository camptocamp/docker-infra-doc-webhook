#!/bin/sh

cd /var/lib/git/sphinx-doc

if ! git config remote.origin.url &> /dev/null; then
  git remote add origin $1
fi
git remote update
git checkout -f origin/master

cd infra-doc && make clean-html && make html
