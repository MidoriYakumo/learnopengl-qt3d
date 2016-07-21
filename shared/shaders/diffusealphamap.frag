#define FP highp

uniform FP vec3 ka;            // Ambient reflectivity
uniform FP vec3 ks;            // Specular reflectivity
uniform FP float shininess;    // Specular shininess factor

uniform FP vec3 eyePosition;

uniform sampler2D diffuseTexture;

varying FP vec3 worldPosition;
varying FP vec3 worldNormal;
varying FP vec2 texCoord;

#pragma include light.inc.frag

void main()
{
	FP vec4 diffuseTextureColor = texture2D( diffuseTexture, texCoord );

	FP vec3 diffuseColor, specularColor;
	adsModel(worldPosition, worldNormal, eyePosition, shininess, diffuseColor, specularColor);

	gl_FragColor = vec4( diffuseTextureColor.rgb * ( ka + diffuseColor ) + ks * specularColor, diffuseTextureColor.a);
//	gl_FragColor = diffuseTextureColor;
}
