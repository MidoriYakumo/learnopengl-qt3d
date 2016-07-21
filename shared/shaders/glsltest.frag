//out vec4 gl_FragColor;

varying vec2 texCoord;

uniform sampler2D texture;

void main()
{
	vec3 color;
	if(gl_FrontFacing)
		color= vec3(mod(gl_FragCoord.xy, 100.)/100., gl_FragDepth);
	else
		color = vec3(1.);

	gl_FragDepth = gl_FragCoord.z/2.;
	gl_FragColor = vec4(color, 1.);
}
