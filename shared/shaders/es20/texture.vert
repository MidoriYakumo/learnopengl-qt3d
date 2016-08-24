
attribute vec3 position;
attribute vec3 color;
attribute vec2 texCoord;

varying vec3 ourColor;
varying vec2 TexCoord;

void main()
{
	gl_Position = vec4(position, 1.);
	ourColor = color;
	TexCoord = texCoord;
}
