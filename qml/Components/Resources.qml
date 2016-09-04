pragma Singleton

import QtQuick 2.7

Item { // This is the global resource router

	readonly property var os2Prefix: {
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		// "android"	: "assets://" ,
		// Compatibility for QML Creator
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	property bool qrcEnabled: false
	property bool fallbackToES30: true
								  & false
	property bool isGLES30: (OpenGLInfo.majorVersion>=3)&&(OpenGLInfo.renderableType==2)
	property bool isGLES20: !isGLES30 && (OpenGLInfo.majorVersion>=2)&&(OpenGLInfo.renderableType==2)
	property bool isGL33Core: ((OpenGLInfo.majorVersion>3)||
							  (OpenGLInfo.majorVersion==3)&&(OpenGLInfo.minorVersion>=3))&&
							  (OpenGLInfo.renderableType==1)

	property string prefix: (qrcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"

	readonly property string shaderPrefix: prefix + "shared/shaders/" + (isGL33Core?"gl33/":(isGLES30||fallbackToES30)?"es30/":"es20/")
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
		console.log("[Resources] isGL33Core: %1, isGLES30: %2, isGLES20: %3.".arg(isGL33Core).arg(isGLES30).arg(isGLES20),
					(!(isGL33Core||isGLES30||isGLES20))?" WARNING: Assuming "+(fallbackToES30?"GLES30":"GLES20"):"")
	}
}
