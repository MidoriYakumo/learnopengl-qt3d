pragma Singleton

import QtQuick 2.7

Item {

	readonly property var os2Prefix: {
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		// Compatibility for QML Creator
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	property bool qrcEnabled: false
	property bool isGLES2: (OpenGLInfo.majorVersion>=2)&&(OpenGLInfo.profile==2)
	property bool isGL33Core: ((OpenGLInfo.majorVersion>3)||
							  (OpenGLInfo.majorVersion==3)&&(OpenGLInfo.minorVersion>=3))&&
							  (OpenGLInfo.profile==1)

	property string prefix: (qrcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"

	readonly property string shaderPrefix: prefix + "shared/shaders/" + (isGL33Core?"gl33/":"es20/")
	function shader(fn){return shaderPrefix + fn}

	readonly property string texturePrefix: prefix + "shared/assets/texture/"
	function texture(fn){return texturePrefix + fn}
	readonly property string imagePrefix: prefix + "shared/assets/image/"
	function image(fn){return imagePrefix + fn}
	readonly property string meshPrefix: prefix + "shared/assets/mesh/"
	function mesh(fn){return meshPrefix + fn}
	readonly property string modelPrefix: prefix + "shared/assets/model/"
	function model(fn){return modelPrefix + fn}

	onPrefixChanged: {
		console.log("[Resources] qrc:%1, prefix:%2".arg(qrcEnabled).arg(prefix))
	}

	onShaderPrefixChanged: {
		console.log("[Resources] isGLES2: %1, isGL33Core: %2.".arg(isGLES2).arg(isGL33Core),
					(!(isGLES2||isGL33Core))?" WARNING: UNCOMPATIBLE CONTEXT!":"")
	}
}
