# Vendor libs
$               = require 'jquery'
lazysizes       = require 'lazysizes'
lsBgset         = require 'lazysizes/plugins/bgset/ls.bgset'
FitVids         = require './vendor/fitvids/FitVids'

# Custom libs
Compatibility   = require './lib/Compatibility'
Stickheader     = require './lib/header/Stickyheader'
Navtoggler      = require './lib/header/Navtoggler'
Contactform     = require './lib/forms/Contactform'
Sectionnext     = require './lib/section/Sectionnext'
Aboutwriter     = require './lib/content/Aboutwriter'

# Remove the Router for now
# Router    = require './lib/Router'

# Whenever the DOM is ready
$(document).ready ->
    new Compatibility()

    # Router.start()

    new Stickheader('.header')

    new Navtoggler('.nav-toggler')

    new Contactform('.form--contact')

    new Sectionnext('.section__next')

    new FitVids('body')

    # @TODO: Add ScrollReveal https://github.com/jlmakes/scrollreveal

    new Aboutwriter()
