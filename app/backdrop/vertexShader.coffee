module.exports = "
#define HEX_SIDE 16.0 \n
#define SQRT3 1.7320508075688772 \n
#define HEX_Y SQRT3/2.0 \n
#define HEX_X 0.25 \n
#define HEX_2X 0.5 \n
#define UPPER \n
#define AUDIO_DATA_LENGTH 30 \n
varying float diffuse;
varying float ao;
varying float aoMask;
varying float sideX;
varying float sideY;
varying float sideZ;
uniform float time;
uniform float currentScroll;
uniform float concavity;
uniform int audioDataIndex;
uniform float audioData[AUDIO_DATA_LENGTH];
float currentScrollOffset = currentScroll * 7.0;
float pseudoChiSquared(float x){
  return x/(x*x+1.0);
}
float getProgression(float time, vec2 coord){
  return clamp(3.0*(2.0*time-0.14*length(coord)),0.0,1.0);
}
float rippleFactor(float time, vec2 coord){
  float progression = getProgression(time,coord);
  return max(5.0*(1.0-time),1.0)*pseudoChiSquared(10.0*progression);
}
float getAudioData(int index){
  return audioData[int(mod(float(audioDataIndex+index),float(AUDIO_DATA_LENGTH)))]*(1.0-float(index)/float(AUDIO_DATA_LENGTH));
}
float getHeight(vec2 coord){
  coord.y-=SQRT3*floor(currentScrollOffset/SQRT3);

  float contentFactor = clamp(5.0*(-coord.y*0.125-1.0+currentScroll*1.0),0.0,1.0);

  float ripple = time<2.0?rippleFactor(time*0.5,coord):0.0;
  float audioRipple = 0.0;
  if(time>2.0){
    float index = length(coord)*float(AUDIO_DATA_LENGTH)/6.0;
    float audioDataLeft = 0.0;
    float audioDataRight = 0.0;
    int indexLeft = int(floor(index));
    if(indexLeft < AUDIO_DATA_LENGTH){
      audioDataLeft = getAudioData(indexLeft);
    }
    int indexRight = int(ceil(index));
    if(indexRight < AUDIO_DATA_LENGTH){
      audioDataRight = getAudioData(indexRight);
    }
    float indexFactor = mod(index,1.0);
    audioRipple+=(1.0-indexFactor)*audioDataLeft+indexFactor*audioDataRight;
  }

  float concavityFactor = time<4.0?clamp(concavity-min(1.0-0.5*(time-2.0),1.0),0.0,1.0):concavity;
  return (1.0-contentFactor)*(ripple-audioRipple*(1.0-concavity)+min(0.05*dot(coord,coord)-3.0,0.0)*getProgression(concavityFactor,coord));

/**min(0.05*dot(coord,coord)-3.0*concavityFactor,0.0)*/
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
    sideX = 1.0;
    heightDiff += max(
      getHeight(coord+vec2(-HEX_X,HEX_Y)),
      getHeight(coord+vec2(HEX_X,HEX_Y))
    );
  }
  else if(id < 2.5){
    sideY = 1.0;
    heightDiff += max(
      getHeight(coord+vec2(HEX_X,HEX_Y)),
      getHeight(coord+vec2(HEX_2X,0.0))
    );
  }
  else if(id < 3.5){
    sideZ = 1.0;
    heightDiff += max(
      getHeight(coord+vec2(HEX_2X,0.0)),
      getHeight(coord+vec2(HEX_X,-HEX_Y))
    );
  }
  else if(id < 4.5){
    sideX = 1.0;
    heightDiff += max(
      getHeight(coord+vec2(HEX_X,-HEX_Y)),
      getHeight(coord+vec2(-HEX_X,-HEX_Y))
    );
  }
  else if(id < 5.5){
    sideY = 1.0;
    heightDiff += max(
      getHeight(coord+vec2(-HEX_X,-HEX_Y)),
      getHeight(coord+vec2(-HEX_2X,0.0))
    );
  }
  else{
    sideZ = 1.0;
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
