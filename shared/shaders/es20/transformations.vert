
attribute vec3 position;
attribute vec3 color;
attribute vec2 texCoord;

varying vec3 ourColor;
varying vec2 TexCoord;

uniform mat4 transform;

void main()
{
	gl_Position = transform * vec4(position, 1.);
	ourColor = color;
	TexCoord = vec2(texCoord.x, 1. - texCoord.y);
}
