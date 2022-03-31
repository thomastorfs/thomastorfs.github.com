$ = require 'jquery'

class Contactform
    constructor: (selector) ->
        @form = $ selector
        @sendBtns = @form.find '[type=submit]'

        @form.submit (e) =>
            e.preventDefault()

            formValues = @form.serializeArray()

            @disableSend()
            @removeMessages()

            $.post 'https://formspree.io/f/xoqrnnzq', formValues
                .done (response) =>
                    if response.ok
                        @addMessage '.actions', 'error', 'Your message has been succesfully sent.'
                    else
                        response.json().then(data) =>
                            if Object.hasOwn(data, 'errors')
                                @addMessage '.actions', 'error', 'error', data["errors"].map(error => error["message"]).join(", ")
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
