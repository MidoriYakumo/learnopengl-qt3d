
attribute vec3 vertexPosition;
attribute vec2 vertexTexCoord;

varying vec2 TexCoord;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

void main()
{
	gl_Position = projectionMatrix * viewMatrix * modelMatrix *
			vec4(vertexPosition, 1.);
	TexCoord = vec2(vertexTexCoord.x, 1. - vertexTexCoord.y);
}
