#version 330 core

in vec2 texCoord;

void main()
{
	float ckSize = 1.0f/9.0f;
	int ckValue =
			((mod(texCoord.x, ckSize*2.0f) > ckSize)?0:1) +
			((mod(texCoord.y, ckSize*2.0f) > ckSize)?0:1);
	vec3 color = vec3(ckValue/3.0f);
	gl_FragColor = vec4(color, 1.0f);
}
