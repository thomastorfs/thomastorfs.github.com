#!/bin/sh

roots clean
roots compile --env="production"

sed -i "" '/public\//d' ./.gitignore
git add .
git commit -m "Publish new static version"

git push origin `git subtree split --prefix public`:gh-pages --force
git push gitlab-public `git subtree split --prefix public`:master --force

git reset HEAD~
git checkout .gitignore
