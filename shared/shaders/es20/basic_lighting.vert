
attribute vec3 vertexPosition;
attribute vec3 vertexNormal;

varying vec3 normal;
varying vec3 fragPos;

uniform mat4 mvp;
uniform mat3 modelNormalMatrix;
uniform mat4 modelMatrix;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.);
	normal = modelNormalMatrix * vertexNormal;
	fragPos = vec3(modelMatrix * vec4(vertexPosition, 1.));
}
attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
attribute vec2 vertexTexCoord;

varying vec2 texCoord;
varying float glowSize;

uniform float cappingSize;
uniform mat4 mvp;

uniform float texCoordScale;

void main()
{
	texCoord = vertexTexCoord * texCoordScale;
	gl_Position = mvp * vec4( vertexPosition * (1.+cappingSize), 1.0 );
	glowSize = 1./(1.+cappingSize)/2.;
}
