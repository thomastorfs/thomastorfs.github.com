page = require('page');
init = require('./init');
controllers = require('./controllers');

module.exports.start = ->
  page('*', init)
  page('about', controllers.about)
