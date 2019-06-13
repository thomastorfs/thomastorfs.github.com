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

# Remove the Router for now
# Router    = require './lib/Router'

# Whenever the DOM is ready
$(document).ready ->
    # Initialize browser compatibility
    new Compatibility()

    # Router.start()

    # Initialize the sticky header.
    new Stickheader('.header')

    # Intialize the toggling on the navigation.
    new Navtoggler('.nav-toggler')

    # Initialize the contact form.
    new Contactform('.form--contact')

    # Initialize the section-next buttons.
    new Sectionnext('.section__next')

    # Initialize the automatic fitting of videos
    new FitVids('body')

    # @TODO: Add ScrollReveal https://github.com/jlmakes/scrollreveal
