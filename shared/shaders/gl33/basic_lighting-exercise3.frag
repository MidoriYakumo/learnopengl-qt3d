#version 330 core

in vec3 lightingColor;

out vec4 color;

uniform vec3 objectColor;

void main()
{
   color = vec4(lightingColor * objectColor, 1.0f);
}
