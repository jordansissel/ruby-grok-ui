require("lib/setup")

Spine = require("spine")
Grok = require("controllers/grok")

class App extends Spine.Controller
  constructor: ->
    super
    @log("Initialized")

    Spine.Route.setup(shim: true)

    # Create the Grok controller

    grok = new Grok
    @append(grok)

module.exports = App
