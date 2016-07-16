import Qt3D.Render 2.0

import "misc.js" as Misc

ShaderProgram {
	readonly property string shaderPath: Misc.rootPrefix() + "/shared/shaders/"

	property string vertName
	property string fragName

	vertexShaderCode: loadSource(shaderPath + vertName + ".vert")
	fragmentShaderCode: loadSource(shaderPath + fragName + ".frag")
}
