attribute vec3 vertexPosition;
attribute vec3 vertexColor;
attribute vec2 vertexTexCoord;

varying vec3 ourColor;
varying vec2 TexCoord;

void main()
{
	gl_Position = vec4(vertexPosition, 1.0f);
	ourColor = vertexColor;
	// We swap the y-axis by substracing our coordinates from 1. This is done because most images have the top y-axis inversed with OpenGL's top y-axis.
	// TexCoord = texCoord;
	TexCoord = vec2(vertexTexCoord.x, 1.0 - vertexTexCoord.y);
}
