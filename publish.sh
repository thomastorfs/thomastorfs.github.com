#!/bin/sh

roots clean
roots compile --env="production"

sed -i "" '/public\//d' ./.gitignore
git add .
git commit -m "Edit .gitignore to publish"

git push origin `git subtree split --prefix public`:gh-pages --force

git reset HEAD~
git checkout .gitignore
