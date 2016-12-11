#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

in vec3 ourColor;
in vec2 TexCoord;

out vec4 color;

uniform sampler2D ourTexture;

void main()
{
	color = texture(ourTexture, TexCoord) * vec4(ourColor, 1.);
}
