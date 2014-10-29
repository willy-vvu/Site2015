#console.time("Load")
projectList = require("projects")
projectHTML = ""
projects = document.getElementById("projects")
detail = document.getElementById("detail")
pages = document.getElementById("pages")
quotes = document.getElementById("quotes")
mainScroll = 0

quotes.data = require("quotes")

projects.data = projectList
projectList.forEach((item)->
  item.content = require("content/" + item.id + "/content")
)
#console.timeEnd("Load")

#scrollProjectPicturesTimeout = 0

loadProject = (id, initially) ->
  project = projectList.filter((item)->item.id is id)
  if project.length>0
    project = project[0]
    detail.project = project
    pages.setAttribute("selected", 0)
    pages.selected = 0
    #clearTimeout(scrollProjectPicturesTimeout)
    #scrollProjectPicturesTimeout = setTimeout(scrollProjectPictures, 1000)
    mainScroll = getScrollTop()
    if(!initially)
      scrollTo($(pages).offset().top, 300)
    document.getElementById("quickscroll").id=project.id;
  else
    pages.setAttribute("selected", 1)
    pages.selected = 1
    #clearTimeout(scrollProjectPicturesTimeout)
    if(!initially)
      scrollTo((if mainScroll is 0 then ($(pages).offset().top - 100) else mainScroll), 300)
    mainScroll = 0

reloadProject = (event) ->
  loadProject(window.location.hash.replace(/[^a-z]/g, ""), !event?)
  if (event)
    event.preventDefault()

getScrollTop = -> Math.max($("body").scrollTop(), $("html").scrollTop())

scrollTo = (position, time) ->
  #console.log(time)
  $("html, body").animate({scrollTop:position}, time)

$("#comedown core-icon-button").click(->
  scrollTo($(pages).offset().top, 1000)
)

window.addEventListener("hashchange", reloadProject, true)

# Parallaxin

#The current scroll position
currentScroll = 0
$(window).scroll(()->
  currentScroll = getScrollTop()
)
###
scrollProjectPictures = () ->
  console.log(pages.selected)
  if pages.selected == 0
    #Do your thing
    pictures = $(detail).find(".images")
    console.log pictures
    clearTimeout(scrollProjectPicturesTimeout)
    scrollProjectPicturesTimeout = setTimeout(scrollProjectPictures, 1000)

inViewOnRight = (image, container) ->
  containerLeft = $(container).scrollLeft()
  containerWidth = $(container).width()
  elemLeft = $(image).offset().left
  elemWidth = $(image).width()
  #0 if not in view, 1 if partially in view, 2 if fully in view
  return containerLeft <= elemLeft
###
reloadProject()

@clock = new THREE.Clock()
clock.start()
Backdrop = require("backdrop/Backdrop")
backdrop = new Backdrop

resize = () ->
  $("#splash").attr("style","height:"+window.innerHeight+"px");
  backdrop.width = window.innerWidth
  backdrop.height = window.innerHeight
  backdrop.resize()

window.addEventListener("resize",resize)
resize()

#The normalized time
time = 0


renderloop = () ->
  if window.requestAnimationFrame?
    window.requestAnimationFrame(renderloop)
  else
    setTimeout(renderloop,1000/60)
  #Update time
  time += Math.min(clock.getDelta(),0.1)

  #Sync variables
  backdrop.time = time
  backdrop.currentScroll = currentScroll

  backdrop.render()

renderloop()
resize()
