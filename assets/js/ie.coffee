$           = require 'jquery'
Picturefill = require 'picturefill'
Flexibility = require 'flexibility'

# After loading the document
$(document).ready ->
    # Lazysizes
    $('.lazyload img').each () ->
        $this = $(this)
        if $this.data('srcset')
            res = /(?:([^"'\s,]+)\s*(?:\s+\d+[wx])(?:,\s*)?)+/g.exec($this.data('srcset'))
            $this.attr 'src', res[res.length-1]
        else
            $this.attr 'src', $this.data('src')
