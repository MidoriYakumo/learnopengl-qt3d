//out vec4 gl_FragColor;

varying vec3 ourColor;

void main( void )
{
	gl_FragColor = vec4(ourColor, 1.0f);
}
