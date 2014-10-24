###
core.coffee
A file in charge of setting up and rendering the hexagonal display.
###
HexGeometry = require("backdrop/HexGeometry")
hexSide = 16 # The number of hexes on one side
backdrop = document.getElementById("backdrop")

# Create a new renderer and attach its element to the dom.
renderer = new THREE.WebGLRenderer()
renderer.setClearColor(0xFFFFFF,1)
backdrop.appendChild(renderer.domElement)

clock = new THREE.Clock()
clock.start()

# A function to be called when the window is resized.
resize = () ->
  renderer.setSize(window.innerWidth,window.innerHeight)
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()

window.addEventListener("resize",resize)
# The function that renders the scene.
render = () ->
  renderer.render(scene,camera)

# The function that is called regularly.
renderloop = () ->
  if window.requestAnimationFrame?
    window.requestAnimationFrame(renderloop)
  else
    setTimeout(renderloop,1000/60)
  hexMesh.material.uniforms.time.value = clock.getElapsedTime()
  hexMesh.material.uniforms.needsUpdate = true
  render()

# Create the scene and camera
window.scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(45, 1, 0.1, 100)
camera.position.z=12
camera.lookAt(new THREE.Vector3(0,0,0))
scene.add(camera)

# Create and add a hexagon mesh to the scene
hexMesh = new THREE.Mesh(HexGeometry(hexSide),
  new THREE.ShaderMaterial({
    vertexShader: require("backdrop/vertexShader")
    fragmentShader: require("backdrop/fragmentShader")
    uniforms:{
      time:{
        type:"f"
        value:0
      }
    }
    shading:THREE.FlatShading
    wireframe:true
  })
)

#TODO: Adjust center
hexMesh.position.set(-8,-7,0)
scene.add(hexMesh)

# GO!
resize()
renderloop()
