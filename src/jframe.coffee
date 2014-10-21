class JFrame
  constructor: (@title) ->
  
  show = ->
    alert("show")

  _visible: false
  visible: (v) ->
    if v is undefined
      @_visible
    else
      @_visible = v
      show()
      