postcss         = require 'postcss'
css_pipeline    = require 'css-pipeline'
browserify      = require 'roots-browserify'
Resizers        = require './assets/js/lib/image/resizers'
dynamic         = require 'dynamic-content'

# Configure Roots
module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'server/**', 'blog/assets/**']
  debug: true
  server:
    clean_urls: true
  locals:
    resize: new Resizers
  jade:
    pretty: true
  extensions: [
    browserify(
      files: 'assets/js/main.coffee',
      out: 'js/app.js',
      sourceMap: true
    ),
    css_pipeline(files: ['assets/css/app.css', 'content/**/*.css'], postcss: true),
    dynamic()
  ]
  postcss:
    use: [
      require('postcss-easy-import')({ glob: true, path: ['assets/css'] }),
      require('postcss-mixins'),
      require('postcss-nested'),
      require('postcss-cssnext')([ 'last 8 versions' ]),
      require('css-mqpacker'),
      require('postcss-simple-vars'),
      require('postcss-reporter')
    ]
