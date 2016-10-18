$               = require 'jquery'
page            = require 'page'
Stickyheader    = require './header/Stickyheader'
Navtoggler      = require './header/Navtoggler'
Contactform     = require './forms/Contactform'


module.exports = (ctx, next) ->
    # ctx.handled = true

    # initialize the sticky header
    new Stickyheader('.header')

    # intialize the toggling on the navigation
    new Navtoggler('.nav-toggler')

    # initialize the contact form
    new Contactform('.form--contact')