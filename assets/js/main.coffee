# Vendor libs
$               = require 'jquery'
lsBgset         = require 'lazysizes/plugins/bgset/ls.bgset'
lazysizes       = require 'lazysizes'
FitVids         = require './vendor/fitvids/FitVids'

# Custom libs
Compatibility   = require './lib/Compatibility'
Navtoggler      = require './lib/header/Navtoggler'
Sectionnext     = require './lib/section/Sectionnext'
Aboutwriter     = require './lib/content/Aboutwriter'

# Remove the Router for now
# Router    = require './lib/Router'

# Whenever the DOM is ready
$(document).ready ->
    new Compatibility()

    new Navtoggler('.nav-toggler')

    new Sectionnext('.section__next')

    new FitVids('body')

    # @TODO: Add ScrollReveal https://github.com/jlmakes/scrollreveal

    new Aboutwriter()
