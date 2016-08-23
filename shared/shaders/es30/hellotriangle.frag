#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

out vec4 color;

void main() {
	color = vec4(1., .5, .2, 1.);
}
