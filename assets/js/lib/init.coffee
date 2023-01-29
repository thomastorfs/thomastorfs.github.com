$               = require 'jquery'
page            = require 'page'
Navtoggler      = require './header/Navtoggler'

module.exports = (ctx, next) ->
    new Navtoggler('.nav-toggler')
