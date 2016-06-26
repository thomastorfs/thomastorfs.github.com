page = require('page');
init = require('./init');
controllers = require('./controllers');

module.exports.start = ->
  page('*', init)
  page('about', controllers.about)
  page('blog', controllers.blog)
  page('contact', controllers.contact)
