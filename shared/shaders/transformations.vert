attribute vec3 vertexPosition;
attribute vec3 vertexColor;
attribute vec2 vertexTexCoord;

varying vec3 ourColor;
varying vec2 TexCoord;

uniform mat4 transform;

void main()
{
	gl_Position = transform * vec4(vertexPosition, 1.0f);
	ourColor = vertexColor;
	TexCoord = vec2(vertexTexCoord.x, 1.0 - vertexTexCoord.y);
}
