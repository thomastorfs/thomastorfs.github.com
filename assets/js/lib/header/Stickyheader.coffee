$ = require 'jquery'
throttle = require 'throttle-debounce/throttle'

class Stickyheader
    constructor: (selector) ->
        # elements
        @header = $ selector
        @w = $ window

        # variables
        @speed = 300
        @lastScrollPosition = 0
        @minScrollPosition = 10
        @minHideScroll = 200
        @hideScrollPosition = 0
        @stickyClass = 'sticky'
        @topClass = 'top'
        @hideClass = 'hide'

        # check when scrolling
        throttle @speed, @w.scroll @updateHeaderClasses

        # force check upon constructing
        @updateHeaderClasses()

    updateHeaderClasses: () =>
        # get the current scroll position
        scrollPosition = @w.scrollTop()

        # scrolled beyond the minimum scroll position
        if scrollPosition > @minScrollPosition
            # add the sticky class
            if !@header.hasClass @stickyClass
                @header.addClass @stickyClass
                @header.removeClass @topClass

            # add or remove the hide class
            # if @lastScrollPosition > (@hideScrollPosition + @minHideScroll) && !@header.hasClass @hideClass
            #     @header.addClass @hideClass
            #
            # else if scrollPosition < @lastScrollPosition
            #     @header.removeClass @hideClass
            #     @hideScrollPosition = scrollPosition

        # returned to top
        else
            # remove the sticky class
            @header.removeClass @stickyClass
            @header.addClass @topClass

        # store the last scroll position
        @lastScrollPosition = scrollPosition

module.exports = Stickyheader
