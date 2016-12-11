#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 position;
in vec3 color;

out vec3 ourColor;

uniform float xOffset;

void main() {
	gl_Position = vec4(position.x + xOffset, position.y, position.z, 1.);
	ourColor = color;
}
