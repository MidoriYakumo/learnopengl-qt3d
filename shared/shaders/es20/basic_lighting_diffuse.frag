
varying vec3 normal;
varying vec3 fragPos;

uniform vec3 lightPos;
uniform vec3 lightColor;
uniform vec3 objectColor;

void main()
{
	// Ambient
	float ambientStrength = .1;
	vec3 ambient = ambientStrength * lightColor;

	// Diffuse
	vec3 norm = normalize(normal);
	vec3 lightDir = normalize(lightPos - fragPos);
	float diff = max(dot(norm, lightDir), 0.);
	vec3 diffuse = diff * lightColor;

	vec3 result = (ambient + diffuse) * objectColor;
	gl_FragColor = vec4(result, 1.);
}
