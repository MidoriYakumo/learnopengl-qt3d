
attribute vec3 position;
attribute vec3 color;

varying vec3 ourColor;

void main() {
	gl_Position = vec4(position, 1.);
	ourColor = position;
}
