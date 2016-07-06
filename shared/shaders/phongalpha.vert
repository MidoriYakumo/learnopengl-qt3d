attribute vec3 vertexPosition;
attribute vec3 vertexNormal;

varying vec3 position;
varying vec3 normal;

uniform mat4 modelView;
uniform mat3 modelViewNormal;
uniform mat4 mvp;

void main()
{
    normal = normalize( modelViewNormal * vertexNormal );
    position = vec3( modelView * vec4( vertexPosition, 1.0 ) );

    gl_Position = mvp * vec4( vertexPosition, 1.0 );
}
