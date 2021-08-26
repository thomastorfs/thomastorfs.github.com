$ = require 'jquery'

class Navtoggler
    constructor: (selector) ->
        @toggler = $ selector
        @body = $ 'body'

        @visibleClass = 'nav--visible'
        @hiddenClass = 'nav--hidden'

        @attachToggle()

    attachToggle: () =>
        @toggler.click (e) =>
            e.preventDefault()

            @body.toggleClass(@visibleClass)
            @body.toggleClass(@hiddenClass)

module.exports = Navtoggler
