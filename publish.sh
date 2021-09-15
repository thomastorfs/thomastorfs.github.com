#!/bin/sh

roots clean
roots compile --env="production"

sed -i "" '/gh-pages/d' ./.gitignore
git add .
git commit -m "Edit .gitignore to publish"

git add .
git commit -m "publish new version to github pages"
git push
git subtree push --prefix public origin gh-pages

git reset HEAD~
git checkout .gitignore
