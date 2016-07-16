import Qt3D.Render 2.0

import "."

ShaderProgram {

	property string vertName
	property string fragName

	vertexShaderCode: loadSource(Resources.shader(vertName + ".vert"))
	fragmentShaderCode: loadSource(Resources.shader(fragName + ".frag"))
}
