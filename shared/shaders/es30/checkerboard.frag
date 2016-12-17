#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

in vec2 texCoord;

void main()
{
	float ckSize = 1./9.;
	int ckValue =
			((mod(texCoord.x, ckSize*2.) > ckSize)?0:1) +
			((mod(texCoord.y, ckSize*2.) > ckSize)?0:1);
	vec3 color = vec3(ckValue/3.);
	gl_FragColor = vec4(color, 1.);
}
