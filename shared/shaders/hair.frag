#version 330 core

in FS_IN {
	vec3 color;
} gs_out;

void main()
{
	gl_FragColor = vec4(gs_out.color, 1.);
}
