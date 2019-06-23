$ = require 'jquery'
throttle = require 'throttle-debounce/throttle'

class Stickyheader
    constructor: (selector) ->
        @header = $ selector
        @w = $ window

        @speed = 300
        @minScrollPosition = 200
        @stickyClass = 'sticky'
        @topClass = 'top'

        # check when scrolling
        throttle @speed, @w.scroll @updateHeaderClasses

        # force check upon constructing
        @updateHeaderClasses()

    updateHeaderClasses: () =>
        # get the current scroll position
        scrollPosition = @w.scrollTop()

        # scrolled beyond the minimum scroll position
        if scrollPosition > @minScrollPosition
            if !@header.hasClass @stickyClass
                @header.addClass @stickyClass
                @header.removeClass @topClass

        # returned to top
        else
            @header.removeClass @stickyClass
            @header.addClass @topClass

module.exports = Stickyheader