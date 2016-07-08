attribute vec3 vertexPosition;
attribute vec2 vertexTexCoord;

uniform mat4 mvp;

varying vec2 TexCoord;

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.0f);
	TexCoord = vec2(vertexTexCoord.x, 1.0 - vertexTexCoord.y);
}
