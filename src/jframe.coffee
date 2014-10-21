class JFrame
  constructor: (title) ->
    @_title = title
    @parentElement = null
    @id = generateId()
    @_visible = false
    @_title = ""
    @_parentSelector = "body"
    @width = "100%"
    @height = "100%"
    @_background = "#a8a8a8"
    @element = null

    createWindow(this)
    this

  generateId = -> '' + Math.ceil(Math.random()*1e12)

  setStyles = (_, element) ->
    div = element || _.element
    div.setAttribute("style", "width: #{_.width}; height: #{_.height}; background: #{_._background}")

  createWindow = (that) ->
    if that.parentElement is null
      that.parentElement = document.querySelector(that._parentSelector)

    if that.element is null
      div = document.createElement("div")
      div.setAttribute("id", "jframe-#{that.id}")
      div.setAttribute("class", "jframe")
      setStyles(that,div)
      that.element = div

  visible: (v) ->
    if v is undefined
      @_visible
    else
      if @_visible is false
        @parentElement.appendChild(@element)
      @_visible = v
      this

  title: (v) ->
    if v is undefined
      @_title
    else
      @_title = v
      this

  size: (w,h) ->
    if arguments.length == 0
      [@width, @height]
    else
      @width = w
      @height = h
      setStyles(this)
      this

  background: (s) ->
    if s is undefined
      @_background
    else
      @_background = s
      setStyles(this)
      this

  parentSelector: (v) ->
    if v is undefined
      @_parentSelector
    else
      @_parentSelector = v
      this
      