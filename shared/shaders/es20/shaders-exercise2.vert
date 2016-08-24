
attribute vec3 position;
attribute vec3 color;

varying vec3 ourColor;

uniform float xOffset;

void main() {
	gl_Position = vec4(position.x + xOffset, position.y, position.z, 1.);
	ourColor = color;
}
