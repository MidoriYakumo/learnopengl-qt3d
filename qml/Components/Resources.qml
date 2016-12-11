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

	property bool appRcEnabled: false
	property bool assetsRcEnabled: false

	property string appPrefix: (appRcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"
	property string assetsPrefix: (assetsRcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"

	property bool fallbackToES30: true
								  & false
	property bool isGLES30: (OpenGLInfo.majorVersion>=3)&&(OpenGLInfo.renderableType!==1)
	property bool isGLES20: !isGLES30 && (OpenGLInfo.majorVersion>=2)&&(OpenGLInfo.renderableType!==1)
	property bool isGL33Core: ((OpenGLInfo.majorVersion>3)||
							  (OpenGLInfo.majorVersion===3)&&(OpenGLInfo.minorVersion>=3))&&
							  (OpenGLInfo.renderableType==1)

	readonly property string shaderPrefix: appPrefix + "shared/shaders/" + (isGL33Core?"gl33/":(isGLES30||fallbackToES30)?"es30/":"es20/")
	function shader(fn){return shaderPrefix + fn}

	readonly property string texturePrefix: assetsPrefix + "shared/assets/texture/"
	function texture(fn){return texturePrefix + fn}
	readonly property string imagePrefix: assetsPrefix + "shared/assets/image/"
	function image(fn){return imagePrefix + fn}
	readonly property string meshPrefix: assetsPrefix + "shared/assets/mesh/"
	function mesh(fn){return meshPrefix + fn}
	readonly property string modelPrefix: assetsPrefix + "shared/assets/model/"
	function model(fn){return modelPrefix + fn}

	onAppPrefixChanged: {
		console.log("[Resources] app:%1:%2".arg(appRcEnabled).arg(appPrefix))
	}

	onAssetsPrefixChanged: {
		console.log("[Resources] assets:%1:%2".arg(assetsRcEnabled).arg(assetsPrefix))
	}

	onShaderPrefixChanged: {
		console.log("[Resources] isGL33Core: %1, isGLES30: %2, isGLES20: %3.".arg(isGL33Core).arg(isGLES30).arg(isGLES20),
					(!(isGL33Core||isGLES30||isGLES20))?" WARNING: Assuming "+(fallbackToES30?"GLES30":"GLES20"):"")
	}
}
