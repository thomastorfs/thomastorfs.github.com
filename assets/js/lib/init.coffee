$               = require 'jquery'
page            = require 'page'
Stickyheader    = require './header/Stickyheader'
Navtoggler      = require './header/Navtoggler'

module.exports = (ctx, next) ->
    # ctx.handled = true

    new Stickyheader('.header')

    new Navtoggler('.nav-toggler')
