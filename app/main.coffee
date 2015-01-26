# Load those projects
projects = require("projects")
projectElements = $()
for project in projects
  projectElements = projectElements.add("
    <a href=\"##{project.id}\">
      <li>
          <div class=\"thumbnail\"
            style=\"background-image:
              url('#{project.id}/#{project.images[0]}')\"></div>
          <label>#{project.name}<label>
        </li>
    </a>
  ")
$("#projectlist").append(projectElements)

loadProject = (id)->
  project = getProject(id)
  if project
    $("#detail>.title").text(project.name)
    $("#detail>.content").html(require("content/#{project.id}"))

getProject = (id)->
  for project in projects
    if project.id is id
      return project
  return null

loadProject("")

$(window).on "hashchange", ()->
  newHash = location.hash.slice(1)
  loadProject(newHash)
