
uniform float nearZ;
uniform float farZ;

float LinearizeDepth(float depth)
{
	float z = depth * 2. - 1.;
	return (2. * nearZ * farZ) / (farZ + nearZ - z * (farZ - nearZ));
}

void main()
{
	float depth = LinearizeDepth(gl_FragCoord.z) / farZ;
	gl_FragColor = vec4(vec3(depth), 1.);
}
