$ = require 'jquery'
page = require 'page'
lazysizes = require 'lazysizes'
lazysizes = require 'lazysizes/plugins/bgset/ls.bgset'

module.exports = (ctx, next) ->
  ctx.handled = true
