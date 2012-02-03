Spine = require("spine")

class GrokResult extends Spine.Controller
  render: -> @html(require("views/grok/result")(@))

  update: (result) -> 
    @result = result
    @log(result)
    @render()
# end class GrokResult

class Grok extends Spine.Controller
  elements:
    "#grok-input": "input" # map to @input

  events:
    "change #grok-input": "input_changed"
    "keyup #grok-input": "input_changed"
    
  constructor: -> 
    super
    @render()
    @result = new GrokResult(el: $("#grok-results", @el))

  render: -> @html(require("views/grok/index")(@))

  input_changed: (e) ->
    val = @input.val()
    @update(val) if val != @text

  update: (val) ->
    @text = val
    #@log(val)
    $.ajax(
      url: "/api/grok"
      type: "POST"
      data:
        text: @text
      success: (data) => @result.update(data)
    )

module.exports = Grok
