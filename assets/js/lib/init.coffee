$ = require('jquery');
page = require('page');

module.exports = (ctx, next) ->
  ctx.handled = true
  $('body').append($('<strong>jquery added</strong>'));

