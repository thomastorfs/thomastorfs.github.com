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
                        'linux',
                        'UNIX',
                        'web frameworks', 
                        'squash', 
                        'nature',
                        'guitar',
                        'machine learning', 
                        'photography',
                        'design', 
                        'typography'
                    ],
                    typeSpeed: 100,
                    backSpeed: 50,
                    shuffle: true,
                    backDelay: 1000,
                    loop: true
                }
            )

module.exports = Aboutwriter
