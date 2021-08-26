$ = require 'jquery'
require 'jquery.easing'

class Sectionnext
    constructor: (selector) ->
        nextButtons = $ selector

        nextButtons.click (e) ->
            e.preventDefault()

            nextWrapper = $(this).parents('.wrapper').next('.wrapper')

            $('html, body').stop().animate({scrollTop: nextWrapper.offset().top}, 500, 'easeOutExpo')

module.exports = Sectionnext
