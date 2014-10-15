console.time("Load")
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

console.timeEnd("Load")

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
    mainScroll = $("body").scrollTop()
    scrollTo($(pages).offset().top, if initially then 100 else 300)
  else
    pages.setAttribute("selected", 1)
    pages.selected = 1
    #clearTimeout(scrollProjectPicturesTimeout)
    if(!initially)
      scrollTo((if mainScroll is 0 then ($(pages).offset().top - 200) else mainScroll), 300)
    mainScroll = 0

reloadProject = (event) ->
  loadProject(window.location.hash.replace(/[^a-z]/g, ""), !event?)
  if (event)
    event.preventDefault()

scrollTo = (position, time) ->
  #console.log(time)
  $("html, body").animate({scrollTop:position}, time)

$("#comedown core-icon-button").click(->
  scrollTo($(pages).offset().top, 1000)
)

window.addEventListener("hashchange", reloadProject, true)
$(document).ready(->
  reloadProject()
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
