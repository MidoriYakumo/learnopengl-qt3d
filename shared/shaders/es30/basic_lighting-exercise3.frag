#version 300 es
#undef lowp
#undef mediump
#undef highp

precision lowp float;

in vec3 lightingColor;

out vec4 color;

uniform vec3 objectColor;

void main()
{
   color = vec4(lightingColor * objectColor, 1.);
}
