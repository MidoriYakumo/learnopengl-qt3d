#version 330 core

layout (location = 0) in vec3 vertexPosition;
layout (location = 1) in vec3 vertexNormal;

out vec3 normal;
out vec3 fragPosition;
out vec3 lightPosition;

uniform mat4 mvp;
uniform mat3 modelViewNormalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 viewMatrix;

uniform vec3 lightPos; // We now define the uniform in the vertex shader and pass the 'view space' lightpos to the fragment shader. lightPos is currently in world space.

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	normal = modelViewNormalMatrix * vertexNormal;
	fragPosition = vec3(modelViewMatrix * vec4(vertexPosition, 1.0f));
	lightPosition = vec3(viewMatrix * vec4(lightPos, 1.0)); // Transform world-space light position to view-space light position
}
