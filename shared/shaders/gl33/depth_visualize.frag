#version 330 core

out vec4 color;

uniform float nearZ;
uniform float farZ;

float LinearizeDepth(float depth)
{
	float z = depth * 2.0f - 1.0f;
	return (2.0f * nearZ * farZ) / (farZ + nearZ - z * (farZ - nearZ));
}

void main()
{
	float depth = LinearizeDepth(gl_FragCoord.z) / farZ;
	color = vec4(vec3(depth), 1.0f);
}
