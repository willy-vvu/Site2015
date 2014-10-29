module.exports = "
#define HEX_SIDE 16.0 \n
#define SQRT3 1.7320508075688772 \n
#define HEX_Y SQRT3/2.0 \n
#define HEX_X 0.25 \n
#define HEX_2X 0.5 \n
#define UPPER \n
varying float diffuse;
varying float ao;
varying float aoMask;
uniform float time;
uniform float currentScroll;
float currentScrollOffset = currentScroll * 5.0;
float pseudoChiSquared(float x){
  return x/(x*x+1.0);
}
float getHeight(vec2 coord){
  coord.y-=SQRT3*floor(currentScrollOffset/SQRT3);
  float phase = max(mod(-0.5*time+0.07*length(coord),1.0)*4.0-3.0,0.0);
  float contentFactor = max(min(5.0*(-coord.y*0.125-1.0+currentScroll*1.0),1.0),0.0);
  float ripple = time<2.0?0.5*pseudoChiSquared(10.0-10.0*phase):0.0;
  return ripple + ((2.0+max(coord.x*coord.x*0.005-0.1,0.0))*contentFactor+(1.0-contentFactor)*min(0.05*dot(coord,coord),max(0.0,2.0*(time-2.0))));
}
void main(){
  float order = floor(position.z / 7.0);
  float id = mod(position.z, 7.0);

  float row = floor(order / HEX_SIDE);

  vec2 coord = vec2(
    float(mod(order, HEX_SIDE)) + 0.5*mod(row,2.0)
      -7.5,
    0.5*SQRT3 * row
      -7.0
  );/*TODO: Adjust Center*/

  float currentHeight = getHeight(coord);
  float heightDiff = -currentHeight;
  if(id < 0.5){

  }
  else if(id < 1.5){
    heightDiff += max(
      getHeight(coord+vec2(-HEX_X,HEX_Y)),
      getHeight(coord+vec2(HEX_X,HEX_Y))
    );
  }
  else if(id < 2.5){
    heightDiff += max(
      getHeight(coord+vec2(HEX_X,HEX_Y)),
      getHeight(coord+vec2(HEX_2X,0.0))
    );
  }
  else if(id < 3.5){
    heightDiff += max(
      getHeight(coord+vec2(HEX_2X,0.0)),
      getHeight(coord+vec2(HEX_X,-HEX_Y))
    );
  }
  else if(id < 4.5){
    heightDiff += max(
      getHeight(coord+vec2(HEX_X,-HEX_Y)),
      getHeight(coord+vec2(-HEX_X,-HEX_Y))
    );
  }
  else if(id < 5.5){
    heightDiff += max(
      getHeight(coord+vec2(-HEX_X,-HEX_Y)),
      getHeight(coord+vec2(-HEX_2X,0.0))
    );
  }
  else{
    heightDiff += max(
      getHeight(coord+vec2(-HEX_2X,0.0)),
      getHeight(coord+vec2(-HEX_X,HEX_Y))
    );
  }
  if(heightDiff<0.0){
    ao = -5.0;
  }
  else{
    ao = min(4.0*heightDiff,1.0);
  }

  if(id < 0.5){
    diffuse = 1000000.0;
    aoMask = -9.0;
  }
  else {
    diffuse = 0.0;
    aoMask = 1.0;
  }

  vec3 pos = position;
  pos.z=currentHeight;
  pos.y=pos.y+mod(currentScrollOffset,SQRT3);
  vec4 mvPosition = modelViewMatrix * vec4( pos, 1.0 );
  gl_Position = projectionMatrix * mvPosition;
}
"
