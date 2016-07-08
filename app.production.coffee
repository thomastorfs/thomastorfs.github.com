fs           = require 'fs'
postcss      = require 'postcss'
uglifyjs     = require 'uglify-js'
browserify   = require 'roots-browserify'
css_pipeline = require 'css-pipeline'
Resizers     = require './assets/js/lib/image/resizers'

# Configure Roots
module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*']
  server:
    clean_urls: true
  open_browser: false
  locals:
    resize: new Resizers
  extensions: [
    browserify(
      files: 'assets/js/main.coffee',
      out: 'js/app.js'
    ),
    css_pipeline(files: ['assets/css/app.css', 'views/**/*.css'], postcss: true)
  ]
  postcss:
    use: [
      require('postcss-easy-import')({ glob: true, path: ['assets/css'] }),
      require('postcss-mixins'),
      require('postcss-nested'),
      require('postcss-cssnext')([ 'last 8 versions' ]),
      require('css-mqpacker'),
      require('postcss-simple-vars'),
      require('postcss-discard-comments')({ removeAll: true }),
      require('cssnano')
    ]
  after:
    ->
      result = uglifyjs.minify('public/js/app.js')
      fs.writeFile('public/js/app.js', result.code)
