#version 330 core

layout (location = 0) in vec3 vertexPosition;
layout (location = 2) in vec2 vertexTexCoord;

out vec2 TexCoord;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

void main()
{
	gl_Position = projectionMatrix * viewMatrix * modelMatrix *
			vec4(vertexPosition, 1.0f);
	TexCoord = vec2(vertexTexCoord.x, 1.0f - vertexTexCoord.y);
}
