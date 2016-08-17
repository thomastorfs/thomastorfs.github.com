$ = require 'jquery'
page = require 'page'
stickyheader = require './header/stickyheader'
navtoggler = require './header/navtoggler'

module.exports = (ctx, next) ->
    ctx.handled = true

    # initialize the sticky header
    new stickyheader('.header')

    # intialize the toggling on the navigation
    new navtoggler('.nav-toggler')