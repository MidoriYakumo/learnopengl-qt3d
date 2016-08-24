import Qt3D.Render 2.0

import "."

ShaderProgram {
	property string vertName: "passthrough"
	property string fragName: "checkerboard"

	vertexShaderCode: loadSource(Resources.shader(vertName + ".vert"))
	fragmentShaderCode: loadSource(Resources.shader(fragName + ".frag"))
}
