(->
  basePath = (-> 
    scripts = document.getElementsByTagName("script")
    src = scripts[scripts.length-1].src
    
    if src.indexOf("/") > -1
      src.substring(0,src.lastIndexOf("/")+1)
    else
      ""
    )()

  include = (jsFile) -> 
    document.write("<script type=\"text/javascript\" src=\"#{basePath + jsFile}\"></script>")

  includeAll = (jsFiles) ->
    include(f) for f in jsFiles

  includeAll ["jframe.js"]

)()