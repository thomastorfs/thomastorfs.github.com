# Vendor
$ = require 'jquery'
lazysizes = require 'lazysizes'
lsBgset   = require 'lazysizes/plugins/bgset/ls.bgset'

# Page logic
Router    = require './lib/Router'

# Start the router
$(document).ready ->
	Router.start()
