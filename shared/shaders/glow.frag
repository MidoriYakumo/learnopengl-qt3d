//out vec4 gl_FragColor;

varying vec2 texCoord;
varying float glowSize;

void main()
{
	vec2 p = texCoord;
	if (p.x>.5) p.x = 1.- p.x;
	if (p.y>.5) p.y = 1.- p.y;
	float border = min(p.x, p.y) ;
//	border += 0.5-length(texCoord-vec2(.5, .5));
//	border = pow(border, 1.5);
//	gl_FragColor = vec4(border, border, border, border);
	gl_FragColor = vec4(texCoord*border, border, border);
}
