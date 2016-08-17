# Vendor
$ = require 'jquery'
lazysizes = require 'lazysizes'
lsBgset   = require 'lazysizes/plugins/bgset/ls.bgset'

# Page logic
Router    = require './lib/router'

# Start the router
$(document).ready ->
	Router.start()
