fs                = require 'fs'
postcss           = require 'postcss'
uglifyjs          = require 'uglify-js'
browserify        = require 'roots-browserify'
css_pipeline      = require 'css-pipeline'
dynamic           = require 'dynamic-content'
ContentRepository = require './lib/ContentRepository'
ImageResizer      = require './lib/ImageResizer'

contentRepository = new ContentRepository

module.exports =
  ignores: ['**/.DS_Store', 'docs/**', '.idea/**', 'README.md', '*.sh', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'assets/js/vendor/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'lib/**', 'server/**', 'views/blog/assets/**', 'package-lock.json', '**.lock', '**.log', 'docs']
  server:
    clean_urls: true
  open_browser: false
  locals:
    resize: new ImageResizer
    blogposts: contentRepository.getBlogPosts(),
    blogposts_grouped: contentRepository.getGroupedBlogPosts(),
    projects: contentRepository.getProjects()
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
      require('postcss-flexibility'),
      require('postcss-cssnext')([ '> 1%, ie 9' ]),
      require('postcss-filter-gradient'),
      require('css-mqpacker'),
      require('postcss-simple-vars'),
      require('postcss-discard-comments')({ removeAll: true }),
      require('cssnano')
    ]
  after:
    () =>
      result = uglifyjs.minify('public/js/app.js')
      fs.writeFile('public/js/app.js', result.code, (err) -> if err then console.error(err))
