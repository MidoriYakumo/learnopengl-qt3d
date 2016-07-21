#version 330 core
layout (triangles) in;
layout (line_strip, max_vertices = 180) out;
const int HL = 180/3;
const float R = 1;//0.95;

in VS_OUT {
	vec3 pos;
	vec3 normal;
	vec3 color;
	float length;
} gs_in[];

out FS_IN {
	vec3 color;
} gs_out;

uniform float time;

void GenerateLine(int index)
{
	vec3 pos = gl_in[index].gl_Position.xyz;
	vec3 normal = gs_in[index].normal;
	float len = gs_in[index].length / HL;

	float i;
	for (i=0;i<HL;i++) {
		gl_Position = vec4(pos, gl_in[index].gl_Position.w);
		gs_out.color = mix(vec3(0.), gs_in[index].color, i/HL);
		EmitVertex();
		normal = normalize(normal + vec3(0., -10./HL, 0.)
			+ vec3(sin(time)*.3/HL, 0., cos(time)*.3/HL)
			) * length(normal);
		len *= R;
		pos = pos + normal * len;
	}
	EndPrimitive();
}


void main()
{
	float top = max(max(gs_in[0].pos.y,
				gs_in[1].pos.y),
				gs_in[2].pos.y);

	if (top>14.) { // assume head
		GenerateLine(0); // First vertex normal
		GenerateLine(1); // Second vertex normal
		GenerateLine(2); // Third vertex normal
	}
}
