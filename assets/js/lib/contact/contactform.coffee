$ = require 'jquery'

class Contactform
    constructor: (selector) ->
        # elements
        @form = $ '.contact-form'

        @form.submit (e) =>
            e.preventDefault()

            formValues = @form.serializeArray()

            $.post 'http://localhost:8080/api/contact-form', $.param(formValues.concat({ name: "referer", value: document.referrer }))

module.exports = Contactform