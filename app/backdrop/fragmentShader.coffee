module.exports = "
varying float diffuse;
varying float ao;
varying float aoMask;
void main(){
  float maskFactor = min(diffuse,1.0)*max(0.0,aoMask);
  float diffuseColor = 0.2*min(diffuse,1.0)+0.8;
  float aoColor = min(1.0-ao,1.0)*0.4+0.6;
  gl_FragColor = vec4(vec3(
    ((1.0-maskFactor)+maskFactor*(aoColor))*diffuseColor)
  , 1.0);
}
"
