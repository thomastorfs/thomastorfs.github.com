#!/bin/sh

# Many thanks to edrex for this script
# https://gist.github.com/edrex/7492725


# replace with your compile command
#roots clean
roots compile --env="production"

# removes the html extension
for f in `ls public/*.html public/**/*.html`; do mv $f "${f%%.*}"; done

# requires s3cmd >= v1.5.0-beta1 for
# https://github.com/s3tools/s3cmd/issues/243
s3cmd sync --default-mime-type="text/html; charset=utf-8" --guess-mime-type --delete-removed public/ s3://thomastorfs.com/