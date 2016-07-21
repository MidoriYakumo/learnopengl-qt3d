#version 330 core
in vec3 vertexPosition;
in vec3 vertexNormal;
in vec2 vertexTexCoord;

out VS_OUT {
	vec3 pos;
	vec3 normal;
	vec3 color;
	float length;
} vs_out;

uniform mat4 mvp;
uniform mat4 inverseModelView;
uniform mat4 projectionMatrix;
uniform sampler2D texture;

mat3 t43(mat4 inMatrix) {
	vec4 i0 = inMatrix[0];
	vec4 i1 = inMatrix[1];
	vec4 i2 = inMatrix[2];

	mat3 outMatrix = mat3(
				 vec3(i0.x, i1.x, i2.x),
				 vec3(i0.y, i1.y, i2.y),
				 vec3(i0.z, i1.z, i2.z)
				 );

	return outMatrix;
}


void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0);
	mat3 normalMatrix = t43(inverseModelView);
	vs_out.color = texture2D(texture, vertexTexCoord).rgb;
	vs_out.length = length(texture2D(texture, vertexTexCoord));
	vs_out.pos = vertexPosition;
	vs_out.normal = vec3(projectionMatrix * vec4(normalMatrix * vertexNormal, 1.0));
}
