fs           = require 'fs'
Model        = require './assets/js/lib/model'
rimraf       = require 'rimraf'
records      = require 'roots-records'
postcss      = require 'postcss'
slugify      = require 'underscore.string/slugify'
uglifyjs     = require 'uglify-js'
browserify   = require 'roots-browserify'
css_pipeline = require 'css-pipeline'

# Instantiate the model
model = new Model

# Configure Roots
module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'views/content/**', 'assets/css/vendor/*', 'data/**']
  server:
    clean_urls: true
  open_browser: false
  locals:
    slugify: slugify
    templateData: model.getAllData()
  extensions: [
    browserify(
      files: 'assets/js/main.coffee',
      out: 'js/app.js'
    ),
    css_pipeline(files: 'assets/css/app.css', postcss: true),
    # records(
    #   projects:
    #     data: model.getProjects(),
    #     template: 'views/work/_project.jade',
    #     out: (project) -> "/work/#{slugify(project.title)}"
    # )
  ]
  postcss:
    use: [
      require('postcss-import')({ path: ['assets/css'] }),
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
