#version 330 core

layout (location = 0) in vec3 vertexPosition;
layout (location = 1) in vec3 vertexNormal;

out vec3 lightingColor; // Resulting color from lighting calculations

uniform mat4 mvp;
uniform mat3 modelNormalMatrix;
uniform mat4 modelMatrix;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 lightColor;
uniform vec3 objectColor;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);

	// Gouraud Shading
	// ------------------------
	vec3 position = vec3(modelMatrix * vec4(vertexPosition, 1.0f));
	vec3 normal = modelNormalMatrix * vertexNormal;

	// Ambient
	float ambientStrength = 0.1f;
	vec3 ambient = ambientStrength * lightColor;

	// Diffuse
	vec3 norm = normalize(normal);
	vec3 lightDir = normalize(lightPos - position);
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = diff * lightColor;

	// Specular
	float specularStrength = 1.0f; // This is set higher to better show the effect of Gouraud shading
	vec3 viewDir = normalize(viewPos - position);
	vec3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0f), 32);
	vec3 specular = specularStrength * spec * lightColor;

	lightingColor = ambient + diffuse + specular;
}
