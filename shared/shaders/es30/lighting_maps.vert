#version 300 es
#undef lowp
#undef mediump
#undef highp

in vec3 vertexPosition;
in vec3 vertexNormal;
in vec2 vertexTexCoord;

out vec3 normal;
out vec3 fragPos;
out vec2 texCoord;

uniform mat4 mvp;
uniform mat3 modelNormalMatrix;
uniform mat4 modelMatrix;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.);
	normal = modelNormalMatrix * vertexNormal;
	fragPos = vec3(modelMatrix * vec4(vertexPosition, 1.));
	texCoord = vertexTexCoord;
}
