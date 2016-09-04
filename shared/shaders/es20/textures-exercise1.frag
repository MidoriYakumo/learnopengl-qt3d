
varying vec3 ourColor;
varying vec2 TexCoord;

uniform sampler2D ourTexture1;
uniform sampler2D ourTexture2;

void main()
{
	gl_FragColor = mix(texture2D(ourTexture1, TexCoord), texture2D(ourTexture2, vec2(1. - TexCoord.x, TexCoord.y)), .2);
}
