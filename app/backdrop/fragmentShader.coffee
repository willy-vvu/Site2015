module.exports = "
varying float diffuse;
varying float ao;
varying float aoMask;
varying vec3 side;
void main(){
  float maskFactor = min(diffuse,1.0)*max(0.0,aoMask);
  float diffuseColor = 1.0;
  if(side.x == 0.0){
    diffuseColor = 0.8;
  }
  else if(side.y == 0.0){
    diffuseColor = 0.85;
  }
  else if(side.z == 0.0){
    diffuseColor = 0.9;
  }
  diffuseColor = (1.0-diffuseColor)*min(diffuse,1.0)+diffuseColor;
  float aoColor = min(1.0-ao,1.0)*0.4+0.6;
  gl_FragColor = vec4(vec3(
    ((1.0-maskFactor)+maskFactor*(aoColor))*diffuseColor)
  , 1.0);
}
"
