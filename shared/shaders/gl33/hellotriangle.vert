# version 330 core

in vec3 vertexPosition;

void main( void )
{
	gl_Position =  vec4(vertexPosition, 1.0f);
}
