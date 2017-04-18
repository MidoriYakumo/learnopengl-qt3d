
struct Material {
	sampler2D diffuse;
	sampler2D specular;
	float shininess;
};

struct DirLight {
	vec3 direction;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct PointLight {
	vec3 position;

	float constant;
	float linear;
	float quadratic;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct SpotLight {
	vec3 position;
	vec3 direction;
	float cutOff;
	float outerCutOff;

	float constant;
	float linear;
	float quadratic;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

varying vec3 normal;
varying vec3 fragPos;
varying vec2 texCoord;

#define MAX_LIGHT_COUNT 4

uniform vec3 viewPos;
uniform int pointLightCount;
uniform Material material;
uniform DirLight dirLight;
uniform SpotLight spotLight;
uniform PointLight pointLights[MAX_LIGHT_COUNT];

// Function prototypes
vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);

void main()
{
	// Properties
	vec3 norm = normalize(normal);
	vec3 viewDir = normalize(viewPos - fragPos);

	// == ======================================
	// Our lighting is set up in 3 phases: directional, point lights and an optional flashlight
	// For each phase, a calculate function is defined that calculates the corresponding color
	// per lamp. In the main() function we take all the calculated colors and sum them up for
	// this fragment's final color.
	// == ======================================
	// Phase 1: Directional lighting
	vec3 result = CalcDirLight(dirLight, norm, viewDir);
	// Phase 2: Directional lighting
	result += CalcSpotLight(spotLight, norm, fragPos, viewDir);
	// Phase 3: Point lights
	for(int i = 0; i < pointLightCount; ++i)
//	for(int i = 0; i < MAX_LIGHT_COUNT; ++i) // const unrolled is faster
		result += CalcPointLight(pointLights[i], norm, fragPos, viewDir);
	// Phase 3: Spot light
	// result += CalcSpotLight(spotLight, norm, FragPos, viewDir);

	gl_FragColor = vec4(result, 1.);
}

// Calculates the color when using a directional light.
vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir)
{
	vec3 lightDir = normalize(-light.direction);
	// Diffuse shading
	float diff = max(dot(normal, lightDir), 0.);
	// Specular shading
	vec3 reflectDir = reflect(-lightDir, normal);
	float spec = pow(max(dot(viewDir, reflectDir), 0.), material.shininess);
	// Combine results
	vec3 ambient = light.ambient * vec3(texture2D(material.diffuse, texCoord));
	vec3 diffuse = light.diffuse * diff * vec3(texture2D(material.diffuse, texCoord));
	vec3 specular = light.specular * spec * vec3(texture2D(material.specular, texCoord));
	return (ambient + diffuse + specular);
}

// Calculates the color when using a spot light.
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
	vec3 lightDir = normalize(light.position - fragPos);
	// Diffuse shading
	float diff = max(dot(normal, lightDir), 0.);
	// Specular shading
	vec3 reflectDir = reflect(-lightDir, normal);
	float spec = pow(max(dot(viewDir, reflectDir), 0.), material.shininess);
	// Attenuation
	float distance = length(light.position - fragPos);
	float attenuation = 1. / (light.constant + light.linear * distance + light.quadratic * (distance * distance));
	// Spotlight intensity
	float theta = dot(lightDir, normalize(-light.direction));
	float intensity = smoothstep(light.outerCutOff, light.cutOff, theta);
	// Combine results
	vec3 ambient = light.ambient * vec3(texture2D(material.diffuse, texCoord));
	vec3 diffuse = light.diffuse * diff * vec3(texture2D(material.diffuse, texCoord));
	vec3 specular = light.specular * spec * vec3(texture2D(material.specular, texCoord));
	ambient *= attenuation * intensity;
	diffuse *= attenuation * intensity;
	specular *= attenuation * intensity;
	return (ambient + diffuse + specular);
}

// Calculates the color when using a point light.
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
	vec3 lightDir = normalize(light.position - fragPos);
	// Diffuse shading
	float diff = max(dot(normal, lightDir), 0.);
	// Specular shading
	vec3 reflectDir = reflect(-lightDir, normal);
	float spec = pow(max(dot(viewDir, reflectDir), 0.), material.shininess);
	// Attenuation
	float distance = length(light.position - fragPos);
	float attenuation = 1. / (light.constant + light.linear * distance + light.quadratic * (distance * distance));
	// Combine results
	vec3 ambient = light.ambient * vec3(texture2D(material.diffuse, texCoord));
	vec3 diffuse = light.diffuse * diff * vec3(texture2D(material.diffuse, texCoord));
	vec3 specular = light.specular * spec * vec3(texture2D(material.specular, texCoord));
	ambient *= attenuation;
	diffuse *= attenuation;
	specular *= attenuation;
	return (ambient + diffuse + specular);
}
