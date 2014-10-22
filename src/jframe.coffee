class JFrame
  @list = {}

  constructor: (title) ->
    @id = generateId()
    JFrame.list[@id] = this

    @_title = title
    @parentElement = null
    @_visible = false
    @_title = ""
    @_parentSelector = "body"
    @_closeButton = true
    @windowCloseListeners = []
    @width = "100%"
    @height = "100%"
    @element = null
    @header = null

    createWindow(this)
    this

  generateId = -> '' + Math.ceil(Math.random()*1e12)

  refreshHeader = (_, header) -> 
    div = header || _.header
    if div.childNodes.length > 0
      n = div.childNodes.length + 1
      div.removeChild(div.childNodes[0]) while n -= 1

    textNode = document.createTextNode(_._title)
    div.appendChild(textNode)

    if _._closeButton
      btn = document.createElement("i")
      btn.setAttribute("class", "fa fa-times close-button")
      btn.setAttribute("onClick", "var f=JFrame.list['#{_.id}']; f.closeButtonClicked(f)")
      div.appendChild(btn)

  setStyles = (_, element) ->
    div = element || _.element
    div.setAttribute("style", "width: #{_.width}; height: #{_.height};")

  createWindow = (that) ->
    if that.parentElement is null
      that.parentElement = document.querySelector(that._parentSelector)

    if that.element is null
      div = 
        ((that,_) ->
          _.setAttribute("id", "jframe-#{that.id}")
          _.setAttribute("class", "jframe")
          setStyles(that,_)
          return _
        )(that,document.createElement("div"))

      that.header = 
        ((that,_) ->
          _.setAttribute("id", "jframe-header-#{that.id}")
          _.setAttribute("class", "jframe-header")
          _.setAttribute("style", "width: 100%; height: 20px;")
          refreshHeader(that,_)
          return _
        )(that,document.createElement("div"))

      that.element = div
      that.element.appendChild(that.header)

  visible: (v) ->
    if v is undefined
      @_visible
    else
      if @_visible is false
        @parentElement.appendChild(@element)
      else
        if @windowCloseListeners.length > 0
          results = (fn(this) for fn in @windowCloseListeners)
          return if results.indexOf(false) > -1

        @parentElement.removeChild(@element)

      @_visible = v
      this

  title: (v) ->
    if v is undefined
      @_title
    else
      @_title = v
      refreshHeader(this)
      this

  size: (w,h) ->
    if arguments.length == 0
      [@width, @height]
    else
      if typeof w is 'number'
        @width = '' + Math.round(w) + 'px'
      else
        @width = ''+w

      if typeof h is 'number'
        @height = '' + Math.round(h) + 'px'
      else
        @height = ''+h

      setStyles(this)
      this

  closeButton: (v) ->
    if v is undefined
      @_closeButton
    else
      @_closeButton = v
      refreshHeader(this)

  addWindowCloseListener: (f) ->
    @windowCloseListeners.push(f)
    this

  removeWindowCloseListener: (f) ->
    index = @windowCloseListeners.indexOf(f)
    if index > -1
      @windowCloseListeners.splice(index,1)
      true
    else
      false

  closeButtonClicked: (that) ->
    that.visible(false)

  parentSelector: (v) ->
    if v is undefined
      @_parentSelector
    else
      @parentElement.removeChild(@element)
      @parentElement = null
      @element = null
      createWindow(this)
      @_parentSelector = v
      this
      