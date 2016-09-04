#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 position;
in vec3 color;
in vec2 texCoord;

out vec3 ourColor;
out vec2 TexCoord;

uniform mat4 transform;

void main()
{
	gl_Position = transform * vec4(position, 1.);
	ourColor = color;
	TexCoord = vec2(texCoord.x, 1. - texCoord.y);
}
