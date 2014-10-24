###
HexGeometry.coffee
Creates a THREE.BufferGeometry and fills it with hexagon points.
Then, links the points up with triangles, and fills the attribute arrays with necessary information.
###
SQRT3 = Math.sqrt(3)
hexPositions = [
  new THREE.Vector2(0,SQRT3/3)
  new THREE.Vector2(0.5,SQRT3/6)
  new THREE.Vector2(0.5,-SQRT3/6)
  new THREE.Vector2(0,-SQRT3/3)
  new THREE.Vector2(-0.5,-SQRT3/6)
  new THREE.Vector2(-0.5,SQRT3/6)
]

module.exports = (hexSide) ->
  geometry = new THREE.BufferGeometry()
  positions = new Float32Array(hexSide*hexSide*7*3)
  #TODO:Update the num of indices below later to save memory
  order = 0;
  indices = new Uint32Array(hexSide*hexSide*12*3)

  indicePusher = new IndicePusher(indices)
  vertexPusher = new VertexPusher(positions)

  for o in [0..hexSide*hexSide-1]
    row = o // hexSide
    x = o % hexSide + 0.5*(row%2)
    y = 0.5*SQRT3 * (row)
    centerPoint = vertexPusher.pushPoint(x,y,order++)
    for h in [0..hexPositions.length-1]
      hexPos = hexPositions[h]
      vertexPusher.pushPoint(x+hexPos.x,y+hexPos.y,order++)
      indicePusher.pushTri(centerPoint,centerPoint+(h+1)%6+1,centerPoint+h+1)

  geometry.addAttribute("index", new THREE.BufferAttribute(indices, 1))
  geometry.addAttribute("position", new THREE.BufferAttribute(positions, 3))
  #geometry.addAttribute("position", new THREE.BufferAttribute(positions, 3))
  return geometry

# Helper class to push points for faces into an array. I originally called it FacePusher.
VertexPusher = (@positions) ->
  @index = 0
  return

VertexPusher :: pushPoint = (x, y, z) ->
  @positions[3*@index] = x
  @positions[3*@index+1] = y
  @positions[3*@index+2] = z
  return @index++

# Helper class to push vertex indices for faces into an array.
IndicePusher = (@indices) ->
  @index = 0
  return

IndicePusher :: push = (n) ->
  @indices[@index++] = n
  return

IndicePusher :: pushTri = (a, b, c) ->
  @push(a)
  @push(b)
  @push(c)
  return

IndicePusher :: pushQuad = (a, b, c) ->
  @pushTri(a,b,c)
  @pushTri(a,c,d)
  return
