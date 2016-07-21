#define FP highp

uniform FP vec3 ka;            // Ambient reflectivity
uniform FP vec3 kd;            // Diffuse reflectivity
uniform FP vec3 ks;            // Specular reflectivity
uniform FP float shininess;    // Specular shininess factor
uniform FP float refractive;
uniform FP float transparency;

uniform FP vec3 eyePosition;
uniform FP samplerCube skyboxTexture;
uniform sampler2DMS screenTextureMS;


varying FP vec3 worldPosition;
varying FP vec3 worldNormal;

#pragma include light.inc.frag

void main()
{
	FP vec3 diffuseColor, specularColor;
	adsModel(worldPosition, worldNormal, eyePosition, shininess, diffuseColor, specularColor);
	FP vec3 skyTextureColor;

	vec3 I = normalize(worldPosition - eyePosition);
	vec3 nNormal = normalize(worldNormal);
	vec3 L = reflect(I, nNormal);
	vec3 R = refract(I, nNormal, refractive);
	float ratio = -dot(I, nNormal);
	skyTextureColor = mix(ka * textureCube(skyboxTexture, L).rgb,
					  mix(ka, textureCube(skyboxTexture, R).rgb, transparency)
						  , ratio);

	gl_FragColor = vec4(skyTextureColor + kd * diffuseColor + ks * specularColor, 1.0 );
}
