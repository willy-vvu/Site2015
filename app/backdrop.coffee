backdrop = document.getElementById("backdrop")

renderer = new THREE.WebGLRenderer()
renderer.setClearColor(0xFFFFFF,1)
backdrop.appendChild(renderer.domElement)

resize = () ->
  renderer.setSize(window.innerWidth,window.innerHeight)
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()


render = () ->
  renderer.render(scene,camera)

renderloop = () ->
  if window.requestAnimationFrame?
    window.requestAnimationFrame(renderloop)
  else
    setTimeout(renderloop,1000/60)
  render()

window.scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(45, 1, 0.1, 100)
camera.position.z=10;
camera.lookAt(new THREE.Vector3(0,0,0))
scene.add(camera)

#scene.add(new THREE.Mesh(new THREE.BoxGeometry(1,1,1),new THREE.MeshNormalMaterial()))

resize()
renderloop()



