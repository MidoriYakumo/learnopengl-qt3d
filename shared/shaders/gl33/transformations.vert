#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;
layout (location = 2) in vec2 texCoord;

out vec3 ourColor;
out vec2 TexCoord;

uniform mat4 transform;

void main()
{
	gl_Position = transform * vec4(position, 1.0f);
	ourColor = color;
	TexCoord = vec2(texCoord.x, 1.0f - texCoord.y);
}
