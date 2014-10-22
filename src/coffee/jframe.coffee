class JFrame extends JComponent
  @list = {}
  @children = {}
  @childrenNodes = {}

  constructor: (title) ->
    super
    # @id = JComponent.generateId()
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
    @header = null
    @contentPane = null

    createWindow(this)
    this

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

      that.contentPane = 
        ((that,_) ->
          _.setAttribute("id", "jframe-contentpane-#{that.id}")
          _.setAttribute("class", "jframe-contentpane")
          _.setAttribute("style", "width: calc(100% - 20px); height: calc(100% - 10px); margin: 0 10px;")
          
          mgn = document.createElement("div")
          mgn.setAttribute("id", "jframe-content-margin-#{that.id}")
          mgn.setAttribute("class", "jframe-content-margin")
          mgn.setAttribute("style", "width: 100%; height: 20px; margin:0;")

          _.appendChild(mgn)
          return _
        )(that,document.createElement("div"))

      that.element = div
      that.element.appendChild(that.contentPane)
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

  add: (component) ->
    JFrame.children[component.id] = component
    JFrame.childrenNodes[component.id] = component.element
    @contentPane.appendChild(component.element)
    component.addNotify(this)
    this

  remove: (component) ->
    @contentPane.removeChild(JFrame.childrenNodes[component.id])
    delete JFrame.children[component.id]
    this

  update: (component) ->
    @remove(component)
    @add(component)
    # i = 0
    # nodes = @contentPane.childNodes
    # while i < nodes.length
    #   break if nodes[i] is component
    #   i += 1
    # @contentPane.childNodes[i] = component


      