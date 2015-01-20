projects = $()
for project in require("projects")
  projects = projects.add("
    <a href=\"##{project.id}\">
      <li>
          <div class=\"thumbnail\" style=\"background-image:url('#{project.id}/#{project.images[0]}')\"></div>
          <label>#{project.name}<label>
        </li>
    </a>
  ")
$("#projectlist").append(projects)
