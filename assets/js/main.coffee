# Vendor libs
$ = require 'jquery'
lazysizes = require 'lazysizes'
lsBgset   = require 'lazysizes/plugins/bgset/ls.bgset'

# Custom libs
Stickheader = require './lib/header/Stickyheader'
Navtoggler = require './lib/header/Navtoggler'
Contactform = require './lib/contact/Contactform'
Sectionnext = require './lib/section/Sectionnext'

# Router    = require './lib/Router'

# Start the router
$(document).ready ->
	# Router.start()

	# initialize the sticky header
	new Stickheader('.header')

	# intialize the toggling on the navigation
	new Navtoggler('.nav-toggler')

	# initialize the contact form
	new Contactform('.form--contact')

	# initialize the section-next buttons
	new Sectionnext('.section__next')