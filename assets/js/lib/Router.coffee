page = require('page');
init = require('./init');

module.exports.start = ->
    page('*', init)
    page.start()
