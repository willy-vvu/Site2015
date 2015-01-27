# Load those projects
projects = require("projects")
projectElements = $()
for project in projects
  projectElements = projectElements.add("
    <a href=\"##{project.id}\" class=\"hideable\">
      <li>
          <div class=\"thumbnail\"
            style=\"background-image:
              url('#{project.id}/#{project.images[0]}')\"></div>
          <label>#{project.name}<label>
        </li>
    </a>
  ")
$("#projectlist").append(projectElements.add("<br>"))

populateProject = ()->
  $("#detail>.title").text(currentproject.name)
  buttonElements = $()
  for link in currentproject.links
    buttonElements = $(buttonElements).add("
      <a href=\"#{link.href}\"><li>#{link.text}</li></a>
    ")
  $("#detail>.list").empty().append(buttonElements.add("<br>"))
  $("#detail>.date").text(currentproject.date)
  $("#detail>.content").html(require("content/#{currentproject.id}"))
  $("#detail>.images").empty()

populateProjectImages = ()->
  imageElements = $()
  for image in currentproject.images[1..]
    imageElements = $(imageElements).add("
      <image src=\"#{currentproject.id}/#{image}\">
    ")
  $("#detail>.images").append(imageElements)

updateProject = (immediate)->
  if currentproject
    if immediate
      populateProject()
      populateProjectImages()
      $("#detail").show()
      $("html, body").animate({ scrollTop: $("#detail").offset().top}, 0)
      $(".comedown.projects").hide()
    else
      $("html, body").animate({ scrollTop: $("#detail").offset().top}, 700)
      $("#projects").addClass("hidden")
      setTimeout ()->
        populateProject()
        $("#detail").removeClass("hidden")
        setTimeout ()->
          populateProjectImages()
          window.location.hash = "#"+currentproject.id
          $("#projectlist a, #projects, #projects h1, #detail>.hideable").removeClass("hidden")
          $(".comedown.projects").addClass("hidden")
        , 400
      , 400
      # Update the arrows

getProject = (id)->
  for project in projects
    if project.id is id
      return project
  return null

currentproject = getProject(location.hash[1..])

$("#projectlist a").on "click", (event)->
  event.preventDefault()
  currentproject = getProject($(this).attr("href")[1..])
  $("#detail, #projectlist a, #projects h1, #detail>.hideable").not(this).addClass("hidden")
  setTimeout ()->
    updateProject()
  , 400
updateProject(true)

$("a.smoothscroll").on "click", (event) ->
  href = $(this).attr("href")
  $("html, body").stop(true).animate({
    scrollTop: $(href).offset().top
  }, 1000, ()=>
    location.hash = if href is "#detail" then "##{currentproject.id}" else href
  )
  event.preventDefault()
