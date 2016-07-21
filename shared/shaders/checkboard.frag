//out vec4 gl_FragColor;

varying vec2 texCoord;

void main()
{
	gl_FragColor = ((mod(texCoord.x, .2)<.1)^^(mod(texCoord.y, .2)<.1))?
				vec4(.6, .6, .6, 1.):vec4(.3, .3, .3, 1.);
}
