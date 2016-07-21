#define FP highp

uniform FP vec3 ka;            // Ambient reflectivity
uniform FP vec3 kd;            // Diffuse reflectivity
uniform FP vec3 ks;            // Specular reflectivity
uniform FP float shininess;    // Specular shininess factor

uniform FP vec3 eyePosition;
uniform FP samplerCube skyboxTexture;

varying FP vec3 worldPosition;
varying FP vec3 worldNormal;

#pragma include light.inc.frag

void main()
{
	FP vec3 diffuseColor, specularColor;
	adsModel(worldPosition, worldNormal, eyePosition, shininess, diffuseColor, specularColor);
	FP vec3 skyTextureColor;

	vec3 I = normalize(worldPosition - eyePosition);
	vec3 R = reflect(I, normalize(worldNormal));
	skyTextureColor = textureCube(skyboxTexture, R).rgb;

	gl_FragColor = vec4( ka * skyTextureColor + kd * diffuseColor + ks * specularColor, 1.0 );
}
