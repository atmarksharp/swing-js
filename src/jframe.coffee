class JFrame
  constructor: (title) ->
    @_title = title
    this

  show = ->
    alert("show")

  _visible: false
  visible: (v) ->
    if v is undefined
      @_visible
    else
      @_visible = v
      show()

  _title: ""
  title: (v) ->
    if v is undefined
      @_title
    else
      @_title = v
      this

  _baseClass: "body"
  baesClass: (v) ->
    if v is undefined
      @_baseClass
    else
      @_baseClass = v
      this
      