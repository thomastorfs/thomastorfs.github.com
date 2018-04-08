$               = require 'jquery'
Contactform     = require './forms/Contactform'


module.exports = (ctx, next) ->
    # initialize the contact form
    new Contactform('.form--contact')