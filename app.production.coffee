fs              = require 'fs'
postcss         = require 'postcss'
uglifyjs        = require 'uglify-js'
browserify      = require 'roots-browserify'
css_pipeline    = require 'css-pipeline'
dynamic         = require 'dynamic-content'
DataModel       = require './lib/DataModel'
ImageResizer    = require './lib/ImageResizer'

# Instantiate the model
dataModel = new DataModel

# Configure Roots
module.exports =
  ignores: ['.idea/**', 'readme.md', 'README', '*.lock', '*.iml', '*.sh', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'assets/js/vendor/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'lib/**', 'server/**', 'views/blog/assets/**']
  server:
    clean_urls: true
  open_browser: false
  locals:
    resize: new ImageResizer
    blogposts: dataModel.getBlogPosts(),
    projects: dataModel.getProjects()
  extensions: [
    browserify(
      files: 'assets/js/main.coffee',
      out: 'js/app.js'
    ),
    css_pipeline(files: ['assets/css/app.css', 'views/**/*.css'], postcss: true),
    dynamic()
  ]
  postcss:
    use: [
      require('postcss-easy-import')({ glob: true, path: ['assets/css'] }),
      require('postcss-mixins'),
      require('postcss-nested'),
      require('postcss-cssnext')([ '> 1%, ie 9' ]),
      require('css-mqpacker'),
      require('postcss-simple-vars'),
      require('postcss-discard-comments')({ removeAll: true }),
      require('cssnano')
    ]
  after:
    ->
      result = uglifyjs.minify('public/js/app.js')
      fs.writeFile('public/js/app.js', result.code)
