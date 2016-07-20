pragma Singleton

import QtQuick 2.7

QtObject {

	readonly property var os2Prefix: {
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		// Compatibility for QML Creator
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	property bool qrcEnabled: false
	property string prefix: (qrcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"
	readonly property string shaderPrefix: prefix + "shared/shaders/"
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
}
