#jshint browser:true */
#!
# FitVids 1.1
#
# Copyright 2013, Chris Coyier - http://css-tricks.com + Dave Rupert - http://daverupert.com
# Credit to Thierry Koblentz - http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/
# Released under the WTFPL license - http://sam.zoy.org/wtfpl/
#

$ = require 'jquery'

class FitVids
    constructor: (wrapper, options) ->
        # Internal counter for unique video names.
        @count = 0

        # Get the wrapper
        $wrapper = $(wrapper)

        # Initialize the settings
        settings =
            customSelector: null
            ignore: null

        # Make sure the style is added
        if !document.getElementById('fit-vids-style')
            # appendStyles: https://github.com/toddmotto/fluidvids/blob/master/dist/fluidvids.js
            head = document.head || document.getElementsByTagName('head')[0]
            css = '.fluid-width-video-wrapper{width:100%;position:relative;padding:0;}.fluid-width-video-wrapper iframe,.fluid-width-video-wrapper object,.fluid-width-video-wrapper embed {position:absolute;top:0;left:0;width:100%;height:100%;}'
            div = document.createElement("div")
            div.innerHTML = '<p>x</p><style id="fit-vids-style">' + css + '</style>'
            head.appendChild(div.childNodes[1])

        # Set the options
        if options
            $.extend( settings, options )

        # Process each wrapper element
        $wrapper.each (i, el) =>
            selectors = [
                'iframe[src*="player.vimeo.com"]',
                'iframe[src*="youtube.com"]',
                'iframe[src*="youtube-nocookie.com"]',
                'iframe[src*="kickstarter.com"][src*="video.html"]',
                'object',
                'embed'
            ]

            if settings.customSelector
                selectors.push(settings.customSelector)

            ignoreList = '.fitvidsignore'

            if settings.ignore
                ignoreList = ignoreList + ', ' + settings.ignore

            $allVideos = $(el).find(selectors.join(','))
            $allVideos = $allVideos.not('object object') # SwfObj conflict patch
            $allVideos = $allVideos.not(ignoreList) # Disable FitVids on this video.

            $allVideos.each (i, vid) =>
                $vid = $ vid
                if $vid.parents(ignoreList).length > 0
                    return # Disable FitVids on this video.

                if (vid.tagName.toLowerCase() == 'embed' && $vid.parent('object').length || $vid.parent('.fluid-width-video-wrapper').length)
                    return

                if ((!$vid.css('height') && !$vid.css('width')) && (isNaN($vid.attr('height')) || isNaN($vid.attr('width'))))
                    $vid.attr('height', 9)
                    $vid.attr('width', 16)

                if ( vid.tagName.toLowerCase() == 'object' || ($vid.attr('height') && !isNaN(parseInt($vid.attr('height'), 10))) )
                    height = parseInt($vid.attr('height'), 10)
                else
                    height = $vid.height()

                if !isNaN(parseInt($vid.attr('width'), 10))
                    width = parseInt($vid.attr('width'), 10)
                else
                    width = $vid.width()

                aspectRatio = height / width

                if !$vid.attr('name')
                    videoName = 'fitvid' + @count
                    $vid.attr('name', videoName)
                    @count++

                $vid.wrap('<div class="fluid-width-video-wrapper"></div>').parent('.fluid-width-video-wrapper').css('padding-top', (aspectRatio * 100)+'%')
                $vid.removeAttr('height').removeAttr('width')

module.exports = FitVids
