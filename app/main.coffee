# Load those projects
projects = require("projects")
projectElements = $()
for project in projects
  projectElements = projectElements.add("
    <a href=\"##{project.id}\" class=\"hideable\">
      <li>
          <div class=\"thumbnail\"
            style=\"background-image:
              url('content/#{project.id}/#{project.images[0]}')\"></div>
          <label>#{project.name}<label>
        </li>
    </a>
  ")
$("#projectlist").append(projectElements)

# Fills the project element with the current project data.
populateProject = ()->
  $("#detail>.title").text(currentProject.name)
  buttonElements = $()
  for link in currentProject.links
    buttonElements = $(buttonElements).add("
      <a href=\"#{link.href}\"><li>#{link.text}</li></a>
    ")
  $("#detail>.list").empty().append(buttonElements)
  $("#detail>.date").text(currentProject.date)
  $("#detail>.content").html(require("content/#{currentProject.id}"))
  $("#detail>.images").empty()


# Fills the project element with images.
# This is meant to be called in a deferred manner.

populateProjectImages = ()->
  imageElements = $()
  for image in currentProject.images[1..]
    imageElements = $(imageElements).add("
      <image src=\"content/#{currentProject.id}/#{image}\">
    ")
  $("#detail>.images").append(imageElements)


updateProject = (immediate)->
  if currentProject
    if immediate
      populateProject()
      populateProjectImages()
      $("#detail").removeClass("hidden").show()
      $("html, body").animate({ scrollTop: $("#splash").height()}, 0)
      $(".comedown.projects").hide()
    else
      $("html, body").animate({ scrollTop: $("#splash").height()}, 700)
      # Fade that splash button color
      projectsComedown = $(".comedown.projects")
      if not projectsComedown.hasClass("hidden")
        projectsComedown.addClass("hidden")
      $("#projects").addClass("hidden")
      setTimeout ()->
        populateProject()
        projectsComedown.hide()
        $("#detail").removeClass("hidden").slideDown(400)
        setTimeout ()->
          populateProjectImages()
          location.hash = currenthash = "#"+currentProject.id
          $("#projectlist a, #projects, #projects h1, #detail>.hideable, nav").removeClass("hidden")
          navBarVisible = true
        , 400
      , 400
      # Update the arrows

getProject = (id)->
  for project in projects
    if project.id is id
      return project
  return null

currentProject = getProject(location.hash[1..])
currenthash = null

$("#projectlist a").on "click", (event)->
  event.preventDefault()
  currentProject = getProject($(this).attr("href")[1..])
  $("#detail, #projectlist a, #projects h1, #detail>.hideable, nav").not(this).addClass("hidden")
  navBarVisible = false
  setTimeout ()->
    updateProject()
  , 400
updateProject(true)

validHashes = ["#about", "#projects", "#detail"]

$("a.smoothscroll").on "click", (event)->
  href = $(this).attr("href")
  if not (href in validHashes)
    $("html, body").stop(true).animate({
      scrollTop: 0
    }, 1000, ()->
      location.hash = currenthash = "#"
    )
  else
    $("html, body").stop(true).animate({
      scrollTop: $(href).offset().top
    }, 1000, ()->
      location.hash = currenthash = if href is "#detail" then "##{currentProject.id}" else href
    )
  event.preventDefault()

$(window).on "hashchange", (event)->
  if location.hash isnt currenthash
    id = location.hash
    project = getProject(id[1..])
    if project?
      currentProject = project
      updateProject()
    else if not (id in validHashes)
      $("html, body").stop(true).animate({
        scrollTop: 0
      }, 1000)
    else
      $("html, body").stop(true).animate({
        scrollTop: $(id).offset().top
      }, 1000)
    currenthash = location.hash

scrollStops = [
  0, 0, 0
]
recomputeScrollStops = ()->
  scrollStops[1] = $("#projects").offset().top
  scrollStops[0] = if currentProject then $("#detail").offset().top else scrollStops[1]
  scrollStops[2] = $("#about").offset().top
recomputeScrollStops()
currentScrollStop = 0
navBarVisible = true
updateNavBar = ()->
  scrollTop = Math.max($("html").scrollTop(), $("body").scrollTop())
  scrollStop = scrollStops.length
  for i in [0...scrollStops.length]
    if scrollStops[i]>scrollTop
      if scrollStops[i] - scrollTop < 128
        scrollStop = -i
      else
        scrollStop = i
      break
  if scrollStop isnt currentScrollStop
    $("nav").attr("class",
      "hideable"+(switch scrollStop
        when 1 then " detail-border"
        when 2 then " projects-border"
        when 3 then " about-border"
        else "")+
      if Math.abs(scrollStop) is Math.abs(currentScrollStop) then " fading-border"
      else ""
    )
    currentScrollStop = scrollStop
$(window).on "resize", recomputeScrollStops

$(window).on "scroll", (event)->
  if navBarVisible
    recomputeScrollStops()
    updateNavBar()

navTimeout = -1
activateNav = ()->
  clearTimeout(navTimeout)
  $("#navbutton").addClass("active")
  $("#navlist").show()
  navlis = $("#navlist li")
  navTimeout = setTimeout ()->
    clearTimeout(navTimeout)
    navlis.eq(0).removeClass("transformed")
    navTimeout = setTimeout ()->
      clearTimeout(navTimeout)
      navlis.eq(1).removeClass("transformed")
      navTimeout = setTimeout ()->
        clearTimeout(navTimeout)
        navlis.eq(2).removeClass("transformed")
      , 100
    , 100
  , 0

deactivateNav = ()->
  $("#navbutton").removeClass("active")
  $("#navlist li").addClass("transformed")
  clearTimeout(navTimeout)
  navTimeout = setTimeout ()->
    $("#navlist").hide()
  , 400


$("#navbutton").on "click", (event)->
  if not $("#navbutton").hasClass("active")
    activateNav()
  else
    deactivateNav()
  event.preventDefault()

$("#navlist a").on "click", ()->
  clearTimeout(navTimeout)
  $("#navlist a").not(this).find("li").addClass("transformed")
  navTimeout = setTimeout deactivateNav, 400
require("splash")
