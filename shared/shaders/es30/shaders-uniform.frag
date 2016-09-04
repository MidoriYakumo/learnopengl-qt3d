#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

out vec4 color;

uniform vec4 ourColor;

void main() {
	color = ourColor;
}
