class JComponent
  constructor: ->
    @element = null
    @id = JComponent.generateId()

  @generateId = ->
    '' + Math.ceil(Math.random()*1e12)

  size: (w,h) ->
    throw new Error("not implemented")