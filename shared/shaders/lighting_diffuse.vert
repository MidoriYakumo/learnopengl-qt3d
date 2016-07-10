attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
attribute vec2 vertexTexCoord;

uniform mat4 mvp;
uniform mat4 modelMatrix;

varying vec3 normal;
varying vec3 worldPos;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	worldPos = vec3(modelMatrix * vec4(vertexPosition, 1.0f));
	normal = vertexNormal;
//	normal = mat3(transpose(inverse(modelMatrix))) * vertexNormal;
}
