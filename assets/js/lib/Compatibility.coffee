require 'browsernizr/test/img/srcset'
require 'browsernizr/test/css/flexbox'
require 'browsernizr/test/forms/placeholder'

$           = require 'jquery'
Modernizr   = require 'browsernizr'
Pre         = require 'pre-js'

class Compatibility
    $(document).ready () ->
        if not Modernizr.srcset
            Pre()
                .js '/js/picturefill-min.js'

        if not Modernizr.flexbox
            body = document.querySelector 'body'
            if body.classList
                body.classList.add 'no-flex'
            else
                body.className += ' no-flex'

        if not Modernizr.placeholder
            placeholders = document.querySelectorAll '[placeholder]'

            for placeholder in placeholders
                do (placeholder) ->
                    initialValue = placeholder.getAttribute 'placeholder'

                    placeholder.value = initialValue

                    placeholder.addEventListener 'focus', () ->
                        if placeholder.value is placeholder.getAttribute 'placeholder'
                            placeholder.value = ''

                    placeholder.addEventListener 'blur', () ->
                        if placeholder.value is ''
                            placeholder.value = initialValue

module.exports = Compatibility
