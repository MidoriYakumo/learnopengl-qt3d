attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
attribute vec2 vertexTexCoord;

uniform mat4 mvp;
uniform mat4 modelMatrix;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos;

varying vec3 effectColor;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	vec3 worldPos = vec3(modelMatrix * vec4(vertexPosition, 1.0f));

	// Ambient
	float ambient = 0.1f;

	// Diffuse
	vec3 norm = normalize(vertexNormal);
	vec3 lightDir = normalize(lightPos - worldPos);
	float diffuse = max(dot(norm, lightDir), 0.0);

	// Specular
	float specularStrength = 0.5f;
	vec3 viewDir = normalize(viewPos - worldPos);
	vec3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
	float specular = specularStrength * spec;

	effectColor = (ambient + diffuse + specular) * lightColor;
}


