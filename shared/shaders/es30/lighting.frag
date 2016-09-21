#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

out vec4 color;

uniform vec3 objectColor;
uniform vec3 lightColor;

void main()
{
	color = vec4(lightColor * objectColor, 1.);
}
