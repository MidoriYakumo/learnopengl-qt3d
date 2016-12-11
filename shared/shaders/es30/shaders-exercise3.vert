#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 position;
in vec3 color;

out vec3 ourColor;

void main() {
	gl_Position = vec4(position, 1.);
	ourColor = position;
}
