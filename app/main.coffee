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
$("#projectlist").append(projectElements)

updateProject = (immediate)->
  if currentproject
    if immediate
      $("#detail>.title").text(currentproject.name)
      $("#detail>.date").text(currentproject.date)
      $("#detail>.content").html(require("content/#{currentproject.id}"))
      $("#detail").show()
      $("html, body").animate({ scrollTop: $("#detail").offset().top}, 0)
      $(".comedown.projects").hide()
    else
      $("html, body").animate({ scrollTop: $("#detail").offset().top}, 800)
      $("#projects").addClass("hidden")
      setTimeout ()->
        $("#detail>.title").text(currentproject.name)
        $("#detail>.date").text(currentproject.date)
        $("#detail>.content").html(require("content/#{currentproject.id}"))
        $("#detail").removeClass("hidden")
        setTimeout ()->
          window.location.hash = "#"+currentproject.id
          $("#projects a, #projects, #projects h1, #detail .comedown").removeClass("hidden")
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

$("#projects a").on "click", (event)->
  event.preventDefault()
  currentproject = getProject($(this).attr("href")[1..])
  $("#detail, #projects a, #projects h1, #detail .comedown").not(this).addClass("hidden")
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
