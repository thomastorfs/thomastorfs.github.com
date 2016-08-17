$ = require 'jquery'

class Navtoggler
    constructor: (selector) ->
        # elements
        @toggler = $(selector)
        @body = $('body')

        # variables
        @visibleClass = 'nav-visible'

        # attach the toggle functionality
        @attachToggle()

    attachToggle: () =>
    	@toggler.click (e) =>
    		# prevent the default click event to happen
    		e.preventDefault()

    		# toggle the navigation visibility
    		@body.toggleClass(@visibleClass)

module.exports = Navtoggler