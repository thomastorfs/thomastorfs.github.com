# Load the Modernizr tests
require 'browsernizr/test/img/srcset'
require 'browsernizr/test/css/flexbox'
require 'browsernizr/test/forms/placeholder'

# Load the required libraries
$           = require 'jquery'
Modernizr   = require 'browsernizr'
Pre         = require 'pre-js'

# Compatibility checks on DOM ready
class Compatibility
    $(document).ready () ->
        # Picturefill
        if not Modernizr.srcset
            Pre()
                .js '/js/picturefill-min.js'

        # Flexbox
        if not Modernizr.flexbox
            body = document.querySelector 'body'
            if body.classList
                body.classList.add 'no-flex'
            else
                body.className += ' no-flex'

        # Simple placeholder polyfill
        if not Modernizr.placeholder
            placeholders = document.querySelectorAll '[placeholder]'

            for placeholder in placeholders
                do (placeholder) ->
                    initialValue = placeholder.getAttribute 'placeholder'

                    # Assign placeholder as the value attribute
                    placeholder.value = initialValue

                    # On focusing
                    placeholder.addEventListener 'focus', () ->
                        if placeholder.value is placeholder.getAttribute 'placeholder'
                            placeholder.value = ''

                    # On blurring
                    placeholder.addEventListener 'blur', () ->
                        if placeholder.value is ''
                            placeholder.value = initialValue

module.exports = Compatibility