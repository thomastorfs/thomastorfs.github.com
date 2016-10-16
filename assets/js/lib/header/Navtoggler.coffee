$ = require 'jquery'

class Navtoggler
    constructor: (selector) ->
        # elements
        @toggler = $ selector
        @body = $ 'body'

        # variables
        @visibleClass = 'nav--visible'
        @hiddenClass = 'nav--hidden'

        # attach the toggle functionality
        @attachToggle()

    attachToggle: () =>
        @toggler.click (e) =>
            # prevent the default click event to happen
            e.preventDefault()

            # toggle the navigation visibility
            @body.toggleClass(@visibleClass)
            @body.toggleClass(@hiddenClass)

module.exports = Navtoggler