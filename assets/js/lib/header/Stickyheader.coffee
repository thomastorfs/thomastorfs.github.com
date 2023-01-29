$ = require 'jquery'
throttle = require 'throttle-debounce/throttle'

class Stickyheader
    constructor: (selector) ->
        @header = $ selector
        @w = $ window

        @speed = 300
        @lastScrollPosition = 0
        @minScrollPosition = 10
        @minHideScroll = 200
        @hideScrollPosition = 0
        @stickyClass = 'sticky'
        @topClass = 'top'
        @hideClass = 'hide'

        throttle @speed, @w.scroll @updateHeaderClasses

        @updateHeaderClasses()

    updateHeaderClasses: () =>
        scrollPosition = @w.scrollTop()

        if scrollPosition > @minScrollPosition
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

        else
            @header.removeClass @stickyClass
            @header.addClass @topClass

        @lastScrollPosition = scrollPosition

module.exports = Stickyheader
