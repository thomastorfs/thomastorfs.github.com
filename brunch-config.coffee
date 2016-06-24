Model = require('./app/lib/model');

# Instantiate the model
model = new Model

# Brunch configuration
exports.config =
  files:
    javascripts:
      joinTo:
        'js/app.js'
    stylesheets:
      order:
        before:
          [
            'app/stylesheets/vendor/*',
            'app/stylesheets/settings.*',
            'app/stylesheets/tools.*',
            'app/stylesheets/generic.*',
            'app/stylesheets/elements.*',
            'app/stylesheets/objects.*',
            'app/stylesheets/components.*',
            'app/stylesheets/trumps.*'
          ]
      joinTo:
        'css/main.css'
    templates:
      joinTo:
        'js/templates.js'

  plugins:
    static_marko:
      createJs: true
      templatePath: 'app/views'
      jsTemplatePath: 'app/views/content'
    postcss:
      processors: [
        require('postcss-simple-vars'),
        require('postcss-import')({ path: ['app/stylesheets'] }),
        require('postcss-mixins'),
        require('postcss-nested'),
        require('postcss-cssnext')([ 'last 8 versions' ]),
        require('css-mqpacker'),
        require('pixrem'),
        require('postcss-discard-comments')({ removeAll: true }),
        require('cssnano'),
        require('postcss-reporter')
      ]
    uglify:
      mangle: true
      compress:
        global_defs:
          DEBUG: false
    browserSync:
      port: 3333
      logLevel: 'debug'

  templateData:
    model.getData()
