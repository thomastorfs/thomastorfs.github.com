$ = require 'jquery'
page = require 'page'
stickyheader = require './header/stickyheader'
navtoggler = require './header/navtoggler'
contactform = require './contact/contactform'

module.exports = (ctx, next) ->
    ctx.handled = true

    # initialize the sticky header
    new stickyheader('.header')

    # intialize the toggling on the navigation
    new navtoggler('.nav-toggler')

    # initialize the contact form
    new contactform('.contact-form')