$ = require 'jquery'
require 'jquery.easing'

class Sectionnext
    constructor: (selector) ->
        nextButtons = $ selector

        nextButtons.click (e) ->
            # prevent the default click event to happen
            e.preventDefault()

            # find the next section
            nextWrapper = $(this).parents('.wrapper').next('.wrapper')

            # scroll towards the next section
            $('html, body').stop().animate({scrollTop: nextWrapper.offset().top}, 500, 'easeOutExpo')

module.exports = Sectionnext