
uniform vec3 objectColor;
uniform vec3 lightColor;

void main()
{
	gl_FragColor = vec4(lightColor * objectColor, 1.);
}
