$       = require 'jquery'
Typedjs = require '../../vendor/typed.js/typed'

class Aboutwriter
    constructor: () ->
        # elements
        $topic = $ '.topic'

        if $topic.length
            typedjs = new Typedjs($topic,
                {
                    strings: [
                        'music',
                        'programming',
                        'photography',
                        'design',
                        'many things'
                    ],
                    typeSpeed: 100,
                    backSpeed: 50,
                    shuffle: true,
                    backDelay: 1000
                }
            )

module.exports = Aboutwriter
