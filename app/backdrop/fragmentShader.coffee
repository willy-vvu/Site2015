module.exports = "
varying float diffuse;
varying float ao;
void main(){
  gl_FragColor = vec4(vec3(
    (min(1.0-ao,1.0)*0.3+0.7)*min(diffuse,1.0))
  , 1.0);
}
"
