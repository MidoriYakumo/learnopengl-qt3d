//out vec4 gl_FragColor;

uniform vec3 objectColor;

varying vec3 effectColor;

void main()
{
	gl_FragColor = vec4(effectColor * objectColor, 1.0f);
}

