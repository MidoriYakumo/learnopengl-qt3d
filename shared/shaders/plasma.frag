//#version 150

#define FP highp

uniform FP vec2 winsize;
uniform FP float time;

FP float displacement(FP vec3 p)
{
	FP float cosT = cos(time);
	FP float sinT = sin(time);

	FP mat2 mat = mat2(cosT, -sinT, sinT, cosT);
	p.xz *= mat;
	p.xy *= mat;
	FP vec3 q = 1.75 * p;

	return length(p + vec3(sinT)) *
		   log(length(p) + 1.0) +
			sin(q.x + sin(q.z + sin(q.y))) * 0.25 - 1.0;
}

void main()
{
	FP vec3 color;
	FP float d = 2.5;
	FP vec2 screenPos = gl_FragCoord.xy / winsize.xy - vec2(0.6, 0.4);
	FP vec3 pos = normalize(vec3(screenPos, -1.0));
	FP float sinT = sin(time) * 0.2;

	// compute plasma color
	for (int i = 0; i < 8; ++i) {
		FP vec3 p = vec3(0.0, 0.0, 5.0) + pos * d;

		FP float positionFactor = displacement(p);
		d += min(positionFactor, 1.0);

		FP float clampFactor =  clamp((positionFactor- displacement(p + 0.1)) * 0.5, -0.1, 1.0);
		FP vec3 l = vec3(0.2 * sinT, 0.35, 0.4) + vec3(5.0, 2.5, 3.25) * clampFactor;
		color = (color + (1.0 - smoothstep(0.0, 2.5, positionFactor)) * 0.7) * l;
	}

	// background color + plasma color
	gl_FragColor = vec4(screenPos * (vec2(1.0, 0.5) + sinT), 0.5 + sinT, 1.0) + vec4(color, 1.0);
}
