class JComponent
  constructor: ->
    @element = null

  @generateId = ->
    '' + Math.ceil(Math.random()*1e12)

  size: (w,h) ->
    throw new Error("not implemented")