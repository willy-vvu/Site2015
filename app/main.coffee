#console.time("Load")
projectList = require("projects")
projectHTML = ""
projects = document.getElementById("projects")
detail = document.getElementById("detail")
pages = document.getElementById("pages")
#quotes = document.getElementById("quotes")
$("#splash").fadeTo(200,1)
mainScroll = 0

#quotes.data = require("quotes")

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
    $(".quickscroll").attr("id",project.id);
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
reloadProject()

#The normalized time
currentScroll = 0
scrollVelocity = 0
maxScrollHeight = Infinity
#Smooth scrolling
window.addEventListener("mousewheel",(event)->
  scrollVelocity += event.deltaY
  maxScrollHeight = Math.max(document.body.scrollHeight,document.documentElement.scrollHeight)-window.innerHeight
  event.preventDefault()
)

update = () ->
  if window.requestAnimationFrame?
    window.requestAnimationFrame(update)
  else
    setTimeout(update,1000/60)

  #Smooth scroll
  if scrollVelocity isnt 0
    currentScroll += scrollVelocity * 0.1
    if currentScroll < 0
      currentScroll = 0
      scrollVelocity = 0
    if currentScroll > maxScrollHeight
      currentScroll = maxScrollHeight
      scrollVelocity = 0
    $("html, body").scrollTop(currentScroll)
    if Math.abs(scrollVelocity)<1
      scrollVelocity = 0
    scrollVelocity *= 0.9

update()
