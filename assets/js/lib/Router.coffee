page = require('page');
init = require('./init');
controllers = require('./Controllers');

module.exports.start = ->
    page('*', init)
    page.start()
