# Vendor libs
$           = require 'jquery'
lazysizes   = require 'lazysizes'
lsBgset     = require 'lazysizes/plugins/bgset/ls.bgset'
FitVids     = require './vendor/fitvids/FitVids'

# Custom libs
Stickheader = require './lib/header/Stickyheader'
Navtoggler  = require './lib/header/Navtoggler'
Contactform = require './lib/forms/Contactform'
Sectionnext = require './lib/section/Sectionnext'
Aboutwriter = require './lib/content/Aboutwriter'

# Router    = require './lib/Router'

# Start the router.
$(document).ready ->
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

    # Initialize the about topic writer.
    new Aboutwriter()
