postcss           = require 'postcss'
css_pipeline      = require 'css-pipeline'
browserify        = require 'roots-browserify'
dynamic           = require 'dynamic-content'
ContentRepository = require './lib/ContentRepository'
ImageResizer      = require './lib/ImageResizer'

contentRepository = new ContentRepository

module.exports =
  ignores: ['**/.DS_Store', 'docs/**', '.idea/**', 'README.md', '*.sh', '**/layout.*', '**/_*', '.gitignore', 'assets/js/lib/**', 'assets/js/vendor/**', 'views/_includes/**', 'views/content/**', 'assets/css/vendor/*', 'lib/**', 'server/**', 'views/blog/assets/**', 'views/reading/assets/**', 'package-lock.json', '**.lock', '**.log', 'docs']
  debug: true
  server:
    clean_urls: true
  locals:
    renderdate: Date.now()
    resize: new ImageResizer
    blogposts: contentRepository.getBlogPosts(),
    blogposts_grouped: contentRepository.getGroupedBlogPosts(),
    reading: contentRepository.getReading(),
    reading_best: contentRepository.getReadingBest(),
    reading_other: contentRepository.getReadingOther(),
    reading_sorted: contentRepository.getReadingSorted(),
    projects: contentRepository.getProjects()
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
