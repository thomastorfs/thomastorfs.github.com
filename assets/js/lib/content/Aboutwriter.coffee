$       = require 'jquery'
Typedjs = require '../../vendor/typed.js/typed'

class Aboutwriter
    constructor: () ->
        $topic = $ '.topic'

        if $topic.length
            typedjs = new Typedjs($topic,
                {
                    strings: [
                        'music',
                        'design',
                        'photography',
                        'books',
                        'ecology',
                        'nature',
                        'meditation',
                        'spirituality',
                        'doing the right thing'
                    ],
                    startDelay: 2000,
                    typeSpeed: 70,
                    backSpeed: 50,
                    shuffle: true,
                    backDelay: 1000
                }
            )

module.exports = Aboutwriter
