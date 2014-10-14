exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    javascripts:
      joinTo: 'app.js'
    stylesheets:
      joinTo: 'app.css'
    templates:
      joinTo: 'app.js'
  onCompile: (generatedFiles) ->
    require('ncp').ncp("bower_components", "public/bower_components", (err) ->
      if (err)
        console.error(err)
      console.log('Copied bower_components.')
    )
    require('ncp').ncp("app/content", "public/content", (err) ->
      if (err)
        console.error(err)
      console.log('Copied content.')
    )
