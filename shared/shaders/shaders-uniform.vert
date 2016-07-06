attribute vec3 vertexPosition;
attribute vec3 color;

varying vec3 ourColor;

void main( void )
{
	gl_Position =  vec4(vertexPosition, 1.0f);
	ourColor = color;
}
