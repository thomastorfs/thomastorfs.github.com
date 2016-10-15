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
  ignores: ['.idea/**', 'readme.md', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'lib/**', 'server/**', 'blog/assets/**']
  debug: true
  server:
    clean_urls: true
  locals:
    resize: new ImageResizer
    blogposts: dataModel.getBlogPosts(),
    projects: dataModel.getProjects()
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
