###
Backdrop.coffee
A file in charge of setting up and rendering the hexagonal display.
###
module.exports = ->
  HexGeometry = require("backdrop/HexGeometry")
  hexSide = 16 # The number of hexes on one side
  backdrop = document.getElementById("backdrop")

  # Create a new renderer and attach its element to the dom.
  renderer = new THREE.WebGLRenderer()
  renderer.setClearColor(0xFFFFFF,1)
  backdrop.appendChild(renderer.domElement)

  #The below are used for FOV calculations.
  #The makimum allowable bounds in the world the camera can see
  maxCameraViewWidth = 8
  maxCameraViewHeight = 5.8
  #Initial Camera Z distance.
  cameraZDepth = 10

  # A function to be called when the window is resized.
  @resize = () ->
    renderer.setSize(window.innerWidth,window.innerHeight)
    camera.aspect = window.innerWidth / window.innerHeight
    camera.fov = 360*Math.atan(Math.min(
      maxCameraViewHeight,
      maxCameraViewWidth/camera.aspect
    )/cameraZDepth) / Math.PI
    camera.updateProjectionMatrix()

  # The function that renders the scene.
  @render = () ->
    renderer.render(scene,camera)
    hexMesh.material.uniforms.time.value = @time
    hexMesh.material.uniforms.currentScroll.value = 0.005*@currentScroll
    hexMesh.material.uniforms.needsUpdate = true

  # Create the scene and camera
  window.scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(0, 1, 0.1, 100)
  camera.position.z=cameraZDepth
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
        currentScroll:{
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

  @time = 0
  @currentScroll = 0
  return

