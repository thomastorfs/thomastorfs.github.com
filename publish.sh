#!/bin/sh

roots clean
roots compile --env="production"

rm -rf docs
cp -R public docs

git add .
git commit -m "Publish new static version"

git push -u origin --all
git push -u gitlab-public --all
