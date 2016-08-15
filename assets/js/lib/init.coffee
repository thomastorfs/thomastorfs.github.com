$ = require 'jquery'
page = require 'page'
stickyheader = require './header/stickyheader'

module.exports = (ctx, next) ->
    ctx.handled = true

    # initialize the sticky header
    new stickyheader('.header')