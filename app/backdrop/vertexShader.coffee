module.exports = "
#define HEX_SIDE 16.0\n\
#define SQRT3 1.7320508075688772\n\
varying vec3 vNormal;
uniform float time;
float getHeight(float x, float y){
  return (0.5*sin(-time+sqrt(x*x+y*y))+0.5)+0.05*(x*x+y*y);
}
void main(){
  float id = floor(position.z/7.0);
  float row = floor(id / HEX_SIDE);
  float x = float(mod(id, HEX_SIDE)) + 0.5*mod(row,2.0);
  float y = 0.5*SQRT3 * row;
  vec3 pos = position;
  pos.z=getHeight(x-8.0,y-7.0); /*TODO: Adjust Center*/
  vec4 mvPosition = modelViewMatrix * vec4( pos, 1.0 );
  gl_Position = projectionMatrix * mvPosition;
}
"
