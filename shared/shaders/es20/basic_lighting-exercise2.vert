
attribute vec3 vertexPosition;
attribute vec3 vertexNormal;

varying vec3 normal;
varying vec3 fragPosition;
varying vec3 lightPosition;

uniform mat4 mvp;
uniform mat3 modelViewNormalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 viewMatrix;

uniform vec3 lightPos; // We now define the uniform in the vertex shader and pass the 'view space' lightpos to the fragment shader. lightPos is currently in world space.

void main()
{
	gl_Position = mvp * vec4(vertexPosition, 1.);
	normal = modelViewNormalMatrix * vertexNormal;
	fragPosition = vec3(modelViewMatrix * vec4(vertexPosition, 1.));
	lightPosition = vec3(viewMatrix * vec4(lightPos, 1.)); // Transform world-space light position to view-space light position
}
