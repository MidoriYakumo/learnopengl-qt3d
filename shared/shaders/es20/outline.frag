varying vec2 texCoord;

void main()
{
	vec2 pos = texCoord;
	if (pos.x > .5) pos.x = 1.- pos.x;
	if (pos.y > .5) pos.y = 1.- pos.y;
	float border = min(pos.x, pos.y);
	gl_FragColor = vec4(texCoord*border, border, border);
	gl_FragColor = vec4(0.5, 0.8, 1.0, 1.0);
}
