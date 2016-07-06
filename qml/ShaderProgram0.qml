import QtQuick 2.6 as QQ2

import Qt3D.Render 2.0

ShaderProgram {
	readonly property var os2Prefix:{
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	function testQrc(){
		try {
			return app.qrcOn;
		}
		catch (err) {
			return false;
		}
	}

	readonly property string prefix: testQrc()?"qrc:":os2Prefix[Qt.platform.os]
	readonly property string shaderPath: prefix + "/shared/shaders/"

	property string vertName
	property string fragName

	vertexShaderCode: loadSource(shaderPath + vertName + ".vert")
	fragmentShaderCode: loadSource(shaderPath + fragName + ".frag")
}
