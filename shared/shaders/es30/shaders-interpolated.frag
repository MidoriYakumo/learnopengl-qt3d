#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

in vec3 ourColor;

out vec4 color;

void main()
{
	color = vec4(ourColor, 1.);
}
