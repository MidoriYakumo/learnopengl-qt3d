attribute vec3 vertexPosition;
attribute vec3 vertexColor;
attribute vec2 vertexTexCoord;

varying vec3 ourColor;
varying vec2 TexCoord;

void main()
{
	gl_Position = vec4(vertexPosition, 1.0f);
	ourColor = vertexColor;
	TexCoord = vertexTexCoord;
}
