
attribute vec3 position;
attribute vec2 texCoord;

varying vec2 TexCoord;

uniform mat4 modelMatrix;
uniform mat4 view;
uniform mat4 projection;

void main()
{
	gl_Position = projection * view * modelMatrix * vec4(position, 1.);
	TexCoord = vec2(texCoord.x, 1. - texCoord.y);
}
