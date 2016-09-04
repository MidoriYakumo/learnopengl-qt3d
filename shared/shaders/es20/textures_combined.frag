
varying vec3 ourColor;
varying vec2 TexCoord;

// Texture samplers
uniform sampler2D ourTexture1;
uniform sampler2D ourTexture2;

void main()
{
	// Linearly interpolate between both textures (second texture is only slightly combined)
	gl_FragColor = mix(texture2D(ourTexture1, TexCoord), texture2D(ourTexture2, TexCoord), .2);
}
