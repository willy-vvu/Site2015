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

Audio = require("Audio")
window.audio = new Audio()

Backdrop = require("backdrop/Backdrop")
backdrop = new Backdrop(audio.array)


resize = () ->
  #$("#splash").css("height",window.innerHeight);
  #Hefully I can use the backdrop container size instead
  backdrop.width = window.innerWidth
  backdrop.height = window.innerHeight
  backdrop.resize()

window.addEventListener("resize",resize)
resize()

#The normalized time
time = 0

scrollVelocity = 0
maxScrollHeight = Infinity
#Smooth scrolling
window.addEventListener("mousewheel",(event)->
  scrollVelocity += event.deltaY
  maxScrollHeight = Math.max(document.body.scrollHeight,document.documentElement.scrollHeight)-window.innerHeight
  event.preventDefault()
)

renderloop = () ->
  if window.requestAnimationFrame?
    window.requestAnimationFrame(renderloop)
  else
    setTimeout(renderloop,1000/60)

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

  delta = Math.min(clock.getDelta(),0.1)

  #Fade in logo if it's time
  if (time<2) and (delta+time>=2)
    $("#splash").fadeTo(1000,1)
    quotes.run()

  #Check the width and height sometimes to detect resize (a workaround)
  if (time % 1) > (time + delta) % 1
    if (backdrop.width isnt window.innerWidth)
      resize()

  #Update time
  time += delta

  #Analyze audio
  audio.analyse()

  #Get that backdrop dancing
  audio.lastAvg = Math.max(audio.avg,0.8*audio.lastAvg+0.2*audio.avg)
  backdrop.audioData[backdrop.audioDataIndex--]=audio.lastAvg/10
  if backdrop.audioDataIndex<0
    backdrop.audioDataIndex=backdrop.audioData.length-1

  #Sync variables
  backdrop.time = time
  backdrop.currentScroll = currentScroll
  if audio.avg == 0
    backdrop.concavity = 0.99*backdrop.concavity+0.01
  else
    backdrop.concavity = 0.8*backdrop.concavity

  backdrop.render()


renderloop()
resize()
