
attribute vec3 vertexPosition;
attribute vec3 vertexNormal;

varying vec3 normal;
varying vec3 fragViewPos;
varying vec3 lightViewPos;

uniform mat4 mvp;
uniform mat3 modelViewNormal;
uniform mat4 modelView;
uniform mat4 viewMatrix;

uniform vec3 lightPos; // We now define the uniform in the vertex shader and pass the 'view space' lightpos to the fragment shader. lightPos is currently in world space.

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.);
	normal = modelViewNormal * vertexNormal;
	fragViewPos = vec3(modelView * vec4(vertexPosition, 1.));
	lightViewPos = vec3(viewMatrix * vec4(lightPos, 1.)); // Transform world-space light position to view-space light position
}
