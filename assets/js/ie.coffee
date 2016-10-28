$            = require 'jquery'
Picturefill  = require 'picturefill'
Flexibility  = require 'flexibility'

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

    # Flexbox
    flexibility = new Flexibility document.documentElement

    # Simple placeholder polyfill
    $("[placeholder]").each ->
        $this = $(this)
        initialValue = $this.attr "placeholder"

        # Assign placeholder as the value attribute
        $this.val initialValue

        # Focused
        $this.focus ->
            if $this.val() is $this.attr "placeholder"
                $this.val ""

        # Blurred
        $this.blur ->
            if $this.val() is ""
                $this.val initialValue
