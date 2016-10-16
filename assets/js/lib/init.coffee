$ = require 'jquery'
page = require 'page'
stickyheader = require './header/Stickyheader'
navtoggler = require './header/Navtoggler'
contactform = require './contact/Contactform'

module.exports = (ctx, next) ->
    ctx.handled = true

    # initialize the sticky header
    new stickyheader('.header')

    # intialize the toggling on the navigation
    new navtoggler('.nav-toggler')

    # initialize the contact form
    new contactform('.form--contact')