#version 330 core

layout (location = 0) in vec3 vertexPosition;
layout (location = 1) in vec3 vertexNormal;
layout (location = 2) in vec2 vertexTexCoord;

out vec3 normal;
out vec3 fragPos;
out vec2 texCoord;

uniform mat4 mvp;
uniform mat3 modelNormalMatrix;
uniform mat4 modelMatrix;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	normal = modelNormalMatrix * vertexNormal;
	fragPos = vec3(modelMatrix * vec4(vertexPosition, 1.0f));
	texCoord = vertexTexCoord;
}
