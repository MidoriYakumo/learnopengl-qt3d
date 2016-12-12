#version 330 core

layout (location = 0) in vec3 vertexPosition;
layout (location = 1) in vec3 vertexNormal;
layout (location = 2) in vec2 vertexTexCoord;

out vec3 normal;
out vec3 fragPos;

uniform mat4 mvp;
uniform mat4 modelMatrix;
uniform mat4 inverseModelMatrix;
uniform mat4 modelNormalMatrix;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	normal = mat3(transpose(inverseModelMatrix)) * vertexNormal;
	fragPos = vec3(modelMatrix * vec4(vertexPosition, 1.0f));
}
