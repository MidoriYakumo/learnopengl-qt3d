#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 vertexPosition;
in vec2 vertexTexCoord;

out vec2 texCoord;

uniform mat4 mvp;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.);
	texCoord = vertexTexCoord;
}
