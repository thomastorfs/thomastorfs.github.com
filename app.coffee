browserify   = require 'roots-browserify'
css_pipeline = require 'css-pipeline'
postcss      = require 'postcss'
Model        = require './assets/js/lib/model'

# Instantiate the model
model = new Model

# Configure Roots
module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/*', 'views/content/**', 'assets/css/vendor/*']
  server:
    clean_urls: true
  locals:
    config:
      templateData: model.getData()
  extensions: [
    browserify(
      files: "assets/js/main.coffee",
      out: 'js/app.js',
      transforms: ['coffeeify']
    ),
    css_pipeline(files: 'assets/css/app.css', postcss: true)
  ]
  postcss:
    use: [
      require('postcss-import')({ path: ['assets/css'] }),
      require('postcss-simple-vars'),
      require('postcss-mixins'),
      require('postcss-nested'),
      require('postcss-cssnext')([ 'last 8 versions' ]),
      require('css-mqpacker'),
      require('pixrem'),
      require('postcss-discard-comments')({ removeAll: true }),
      require('cssnano'),
      require('postcss-reporter')
    ]


