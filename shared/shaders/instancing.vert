#version 330 core

attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
attribute vec2 vertexTexCoord;

varying vec3 worldPosition;
varying vec3 worldNormal;
varying vec2 texCoord;

uniform mat4 modelMatrix;
uniform mat3 modelNormalMatrix;
uniform mat4 mvp;
uniform int instanceCount;

const float PI = 3.14159;

float rand(vec3 r) { return fract(sin(dot(r.xy,vec2(1.38984*sin(r.z),1.13233*cos(r.z))))*653758.5453); }


void main()
{
	texCoord = vertexTexCoord;
	worldNormal = normalize( modelNormalMatrix * vertexNormal );
	worldPosition = vec3( modelMatrix * vec4( vertexPosition, 1.0 ) );

	float x, y, z, s, r1, r2;
	r1 = rand(vec3(gl_InstanceID, .1, .2));
	r2 = rand(vec3(.1, gl_InstanceID, .2));
	x = sin(gl_InstanceID * PI * 2 / instanceCount) * 4. + r1 * 2. - 1.;
	y = cos(gl_InstanceID * PI * 2 / instanceCount) * 4. + r2 * 2. - 1.;
	s = pow(rand(vec3(x, y, gl_InstanceID)) * .9, 8.);
	z = rand(vec3(x, y, s)) * .8;
	gl_Position = mvp * vec4( vertexPosition * s + 5. * vec3(x, z, y), 1.0 );
}
