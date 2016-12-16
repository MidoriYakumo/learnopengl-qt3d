
varying vec3 lightingColor;

uniform vec3 objectColor;

void main()
{
   gl_FragColor = vec4(lightingColor * objectColor, 1.);
}
