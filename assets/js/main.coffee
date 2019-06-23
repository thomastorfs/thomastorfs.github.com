# Vendor libs
$               = require 'jquery'

# Custom libs
Compatibility   = require './lib/Compatibility'

# Remove the Router for now
# Router    = require './lib/Router'

# Whenever the DOM is ready
$(document).ready ->
    # Initialize browser compatibility
    new Compatibility()

    # @TODO: Add ScrollReveal https://github.com/jlmakes/scrollreveal
