Spine = require("spine")

class TextInputController extends Spine.Controller
  constructor: ->
    super
    @render()

  render: ->
    @html require("views/grok/index")(@)

class Grok extends Spine.Controller
  constructor: ->
    super
    @textinput = new TextInputController

    @routes(
      "/grok": (params) -> @textinput.active(params)
      #"/events/:name": (params) -> @event.active(params)
      #"/events/:name/create": (params) -> @event_create.active(params)
    )

module.exports = Grok
