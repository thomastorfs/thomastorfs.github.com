$ = require 'jquery'

class Contactform
    constructor: (selector) ->
        # elements
        @form = $ selector
        @sendBtns = @form.find '[type=submit]'

        # Submit the form
        @form.submit (e) =>
            e.preventDefault()

            # Get the form values
            formValues = @form.serializeArray()

            # Disable the submit button and remove any messages
            @disableSend()
            @removeMessages()

            # Send the email
            $.post 'http://api.thomastorfs.com/api/contact-form', $.param(formValues)
                .done (response) =>
                    if response.errors? && !response.errors.code
                        for error in response.errors
                            @addMessage '[name="' + error.param + '"]', 'error', error.msg
                    else if response.success
                        @addMessage '.actions', 'error', 'Your message has been succesfully sent.'
                    else
                        @addMessage '.actions', 'error', 'An error occurred while sending your message.'

                    @enableSend()
                .fail (response) =>
                    @addMessage '.actions', 'error', 'An error occurred while sending your message.'
                    @enableSend()

    addMessage: (id, type, body) =>
        element = @form.find id

        if element.length
            $msg = $ '<div />', {class: 'message ' + type}
            $msg.html body
            $msg.hide()
            element.before $msg
            $msg.slideDown()

    removeMessages: () =>
        msgs = @form.find '.message'
        msgs.slideUp(() ->
            $ this remove()
        )

    disableSend: () =>
        @sendBtns.prop 'disabled', true

    enableSend: () =>
        @sendBtns.prop 'disabled', false

module.exports = Contactform