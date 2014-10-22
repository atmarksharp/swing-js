class JLabel extends JComponent
  constructor: (text="") ->
    super
    @_text = text
    @container = null

    @refresh(this)

  refresh: (_) ->
    e = document.createElement("span")
    e.setAttribute("id", "jlabel-#{_.id}")
    e.setAttribute("class", "jlabel")

    textNode = document.createTextNode(_._text)
    e.appendChild(textNode)

    _.element = e
    if _.container isnt null
      _.container.update(this) 

  addNotify: (container) ->
    @container = container

  text: (s) ->
    if s is undefined
      @_text
    else
      @_text = s
      @refresh(this)
