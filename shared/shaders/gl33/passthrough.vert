#version 330 core

in vec3 vertexPosition;
in vec2 vertexTexCoord;

out vec2 texCoord;

uniform mat4 mvp;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	texCoord = vertexTexCoord;
}
