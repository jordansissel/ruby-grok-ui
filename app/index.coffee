require("lib/setup")

Spine = require("spine")
Grok = require("controllers/grok")

class App extends Spine.Controller
  constructor: ->
    super
    @log("Initialized")

    # Create the Grok controller
    @grok = new Grok
    @navigate "/grok"

module.exports = App
