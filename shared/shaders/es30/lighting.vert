#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 vertexPosition;
in vec2 vertexTexCoord;

out vec2 TexCoord;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

void main()
{
	gl_Position = projectionMatrix * viewMatrix * modelMatrix *
			vec4(vertexPosition, 1.);
	TexCoord = vec2(vertexTexCoord.x, 1. - vertexTexCoord.y);
}
