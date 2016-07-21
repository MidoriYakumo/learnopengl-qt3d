attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
attribute vec2 vertexTexCoord;

varying vec3 worldPosition;
varying vec3 worldNormal;
varying vec2 texCoord;

uniform mat4 modelMatrix;
uniform mat3 modelNormalMatrix;
uniform mat4 mvp;

void main()
{
	texCoord = vertexTexCoord;
	worldNormal = normalize( modelNormalMatrix * vertexNormal );
	worldPosition = vec3( modelMatrix * vec4( vertexPosition, 1.0 ) );

	gl_Position = mvp * vec4( vertexPosition, 1.0 );
//	gl_PointSize = gl_VertexID;
}
