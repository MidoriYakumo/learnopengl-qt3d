
attribute vec3 vertexPosition;
attribute vec2 vertexTexCoord;

varying vec2 texCoord;

uniform mat4 mvp;
uniform float outlineRatio;

void main()
{
	gl_Position = mvp * vec4(vertexPosition * (1. + outlineRatio), 1.);
	texCoord = vertexTexCoord;
}
