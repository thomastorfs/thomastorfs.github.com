postcss         = require 'postcss'
css_pipeline    = require 'css-pipeline'
browserify      = require 'roots-browserify'
dynamic         = require 'dynamic-content'
DataModel       = require './lib/DataModel'
ImageResizer    = require './lib/ImageResizer'

# Instantiate the model
dataModel = new DataModel

# Configure Roots
module.exports =
  ignores: ['.idea/**', 'readme.md', '*.sh', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'assets/js/vendor/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'lib/**', 'server/**', 'views/blog/assets/**']
  debug: true
  server:
    clean_urls: true
  locals:
    resize: new ImageResizer
    blogposts: dataModel.getBlogPosts()
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
      require('postcss-flexibility'),
      require('postcss-cssnext')([ '> 1%, ie9' ]),
      require('postcss-filter-gradient'),
      require('css-mqpacker'),
      require('postcss-simple-vars'),
      require('postcss-reporter')
    ]
