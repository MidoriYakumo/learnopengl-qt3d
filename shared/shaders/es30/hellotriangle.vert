#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 position;

void main() {
	gl_Position = vec4(position, 1.);
}
