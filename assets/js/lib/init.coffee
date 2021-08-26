$               = require 'jquery'
page            = require 'page'
Stickyheader    = require './header/Stickyheader'
Navtoggler      = require './header/Navtoggler'
Contactform     = require './forms/Contactform'


module.exports = (ctx, next) ->
    # ctx.handled = true

    new Stickyheader('.header')

    new Navtoggler('.nav-toggler')

    new Contactform('.form--contact')
