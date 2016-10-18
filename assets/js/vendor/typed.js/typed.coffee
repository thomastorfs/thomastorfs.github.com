# The MIT License (MIT)

# Typed.js | Copyright (c) 2014 Matt Boldt | www.mattboldt.com

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

$ = require 'jquery'

class Typedjs
    constructor: (el, options) ->
        # chosen element to manipulate text
        @el = $(el)

        # options
        @options = $.extend({}, @defaults(), options)

        # attribute to type into
        @isInput = @el.is 'input'
        @attr = @options.attr

        # show cursor
        @showCursor = if @isInput then false else @options.showCursor

        # text content of element
        @elContent = if @attr then @el.attr(@attr) else @el.text()

        # html or plain text
        @contentType = @options.contentType

        # typing speed
        @typeSpeed = @options.typeSpeed

        # add a delay before typing starts
        @startDelay = @options.startDelay

        # backspacing speed
        @backSpeed = @options.backSpeed

        # amount of time to wait before backspacing
        @backDelay = @options.backDelay

        # div containing strings
        @stringsElement = @options.stringsElement

        # input strings of text
        @strings = @options.strings

        # character number position of current string
        @strPos = 0

        # current array position
        @arrayPos = 0

        # number to stop backspacing on.
        # default 0, can change depending on how many chars
        # you want to remove at the time
        @stopNum = 0

        # Looping logic
        @loop = @options.loop
        @loopCount = @options.loopCount
        @curLoop = 0

        # for stopping
        @stop = false

        # custom cursor
        @cursorChar = @options.cursorChar

        # shuffle the strings
        @shuffle = @options.shuffle
        # the order of strings
        @sequence = []

        # All systems go!
        @build()

    init: () =>
        # begin the loop w/ first current string (global @strings)
        # current string will be passed as an argument each time after this
        typewriteCallback = () =>
            for i in [0..@strings.length]
                @sequence[i] = i

            # shuffle the array if true
            if (@shuffle)
                @sequence = @shuffleArray(@sequence)

            # Start typing
            @typewrite(@strings[@sequence[@arrayPos]], @strPos)

        @timeout = setTimeout typewriteCallback, @startDelay

    build: () =>
        # Insert cursor
        if @showCursor == true
            @cursor = $("<span class=\"typed-cursor\">" + @cursorChar + "</span>")
            @el.after(@cursor)

        if @stringsElement
            @strings = []
            @stringsElement.hide()
            strings = @stringsElement.find('p')
            $.each(strings, (key, value) =>
                @strings.push($(value).html())
            )

        @init()

    # pass current string state to each function, types 1 char per call
    typewrite: (curString, curStrPos) =>
        # exit when stopped
        if @stop == true
            return

        # varying values for setTimeout during typing
        # can't be global since number changes each time loop is executed
        humanize = Math.round(Math.random() * (100 - 30)) + @typeSpeed

        # ------------- optional ------------- #
        # backpaces a certain string faster
        # ------------------------------------ #
        # if (@arrayPos == 1){
        #  @backDelay = 50;
        # }
        # else{ @backDelay = 500; }

        # contain typing function in a timeout humanize'd delay
        typingCallback = () =>
            # check for an escape character before a pause value
            # format: \^\d+ .. eg: ^1000 .. should be able to print the ^ too using ^^
            # single ^ are removed from string
            charPause = 0
            substr = curString.substr(curStrPos)

            if (substr.charAt(0) == '^')
                skip = 1 # skip atleast 1
                if (/^\^\d+/.test(substr))
                    substr = /\d+/.exec(substr)[0]
                    skip += substr.length
                    charPause = parseInt(substr)

                # strip out the escape character and pause value so they're not printed
                curString = curString.substring(0, curStrPos) + curString.substring(curStrPos + skip)

            if (@contentType == 'html')
                # skip over html tags while typing
                curChar = curString.substr(curStrPos).charAt(0)
                if (curChar == '<' || curChar == '&')
                    tag = ''
                    endTag = ''

                    if (curChar == '<')
                        endTag = '>'
                    else
                        endTag = ';'

                    while (curString.substr(curStrPos).charAt(0) != endTag)
                        tag += curString.substr(curStrPos).charAt(0)
                        curStrPos++
                    curStrPos++
                    tag += endTag

            # timeout for any pause after a character
            pauseAfterChar = () =>
                if (curStrPos == curString.length)
                    # fires callback function
                    @options.onStringTyped(@arrayPos)

                    # is this the final string
                    if (@arrayPos == @strings.length - 1)
                        # animation that occurs on the last typed string
                        @options.callback()

                        @curLoop++

                        # quit if we wont loop back
                        if (@loop == false || @curLoop == @loopCount)
                            return

                    backspaceCallback = () =>
                        @backspace(curString, curStrPos)

                    timeout = setTimeout backspaceCallback, @backDelay

                else
                    # call before functions if applicable #
                    if (curStrPos == 0)
                        @options.preStringTyped(@arrayPos)

                    # start typing each new char into existing string
                    # curString: arg, @el.html: original text inside element
                    nextString = curString.substr(0, curStrPos + 1)

                    if (@attr)
                        @el.attr(@attr, nextString)
                    else
                        if (@isInput)
                            @el.val(nextString)
                        else if (@contentType == 'html')
                            @el.html(nextString)
                        else
                            @el.text(nextString)

                    # add characters one by one
                    curStrPos++
                    # loop the function
                    @typewrite(curString, curStrPos)

                # end of character pause
            timeout = setTimeout pauseAfterChar charPause

        # humanized value for typing
        timeout = setTimeout typingCallback, humanize

    backspace: (curString, curStrPos) =>
        # exit when stopped
        if @stop == true
            return

        # varying values for setTimeout during typing
        # can't be global since number changes each time loop is executed
        humanize = Math.round(Math.random() * (100 - 30)) + @backSpeed

        backspaceCallback = () =>
            # ----- this part is optional ----- #
            # check string array position
            # on the first string, only delete one word
            # the stopNum actually represents the amount of chars to
            # keep in the current string. In my case it's 14.
            # if (@arrayPos == 1){
            #  @stopNum = 14;
            # }
            #every other time, delete the whole typed string
            # else{
            #  @stopNum = 0;
            # }

            if (@contentType == 'html')
                # skip over html tags while backspacing
                if (curString.substr(curStrPos).charAt(0) == '>')
                    tag = ''
                    while (curString.substr(curStrPos).charAt(0) != '<')
                        tag -= curString.substr(curStrPos).charAt(0)
                        curStrPos--
                    curStrPos--
                    tag += '<'

            # ----- continue important stuff ----- #
            # replace text with base text + typed characters
            nextString = curString.substr(0, curStrPos)

            if (@attr)
                @el.attr(@attr, nextString)
            else
                if (@isInput)
                    @el.val(nextString)
                else if (@contentType == 'html')
                    @el.html(nextString)
                else 
                    @el.text(nextString)

            # if the number (id of character in current string) is
            # less than the stop number, keep going
            if (curStrPos > @stopNum) 
                # subtract characters one by one
                curStrPos--
                # loop the function
                @backspace(curString, curStrPos)

            # if the stop number has been reached, increase
            # array position to next string
            else if (curStrPos <= @stopNum)
                @arrayPos++

                if (@arrayPos == @strings.length)
                    @arrayPos = 0

                    # Shuffle sequence again
                    if (@shuffle)
                        @sequence = @shuffleArray(@sequence)

                    @init()
                else
                    @typewrite(@strings[@sequence[@arrayPos]], curStrPos)

        # humanized value for typing
        timeout = setTimeout backspaceCallback, humanize

    ##
    # Shuffles the numbers in the given array.
    # @param {Array} array
    # @returns {Array}
    ##
    shuffleArray: (array) =>
        tmp = null
        current = null
        top = array.length

        if (top) while(--top)
            current = Math.floor(Math.random() * (top + 1))
            tmp = array[current]
            array[current] = array[top]
            array[top] = tmp

        return array

    # Start & Stop currently not working

    # , stop: function() {
    #     var self = this;

    #     @stop = true;
    #     clearInterval(@timeout);
    # }

    # , start: function() {
    #     var self = this;
    #     if(@stop == false)
    #        return;

    #     @stop = false;
    #     @init();
    # }

    # Reset and rebuild the element

    reset: () =>
        clearInterval @timeout
        id = @el.attr('id')

        @el.after('<span id="' + id + '"/>')
        @el.remove()

        if (typeof @cursor != 'undefined')
            @cursor.remove()

        # Send the callback
        @options.resetCallback()

    defaults: () =>
        defaults = {
            strings: ["These are the default values...", "You know what you should do?", "Use your own!", "Have a great day!"],
            stringsElement: null,
            # typing speed
            typeSpeed: 0,
            # time before typing starts
            startDelay: 0,
            # backspacing speed
            backSpeed: 0,
            # shuffle the strings
            shuffle: false,
            # time before backspacing
            backDelay: 500,
            # loop
            loop: false,
            # false = infinite
            loopCount: false,
            # show cursor
            showCursor: true,
            # character for cursor
            cursorChar: "|",
            # attribute to type (null == text)
            attr: null,
            # either html or text
            contentType: 'html',
            # call when done callback function
            callback: (->),
            # starting callback function before each string
            preStringTyped: (->),
            #callback for every typed string
            onStringTyped: (->),
            # callback for reset
            resetCallback: (->)
        }

module.exports = Typedjs
