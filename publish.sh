#!/bin/sh

roots clean
roots compile --env="production"

git add .
git commit -m "publish new version to github pages"
git push
git subtree push --prefix public origin gh-pages
