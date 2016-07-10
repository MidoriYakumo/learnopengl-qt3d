import Qt3D.Render 2.0

TextureImage { // only local resource(file, assets, qrc) is supported, see src/TextureImage
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
	readonly property string texturePath: prefix + "/shared/assets/texture/"

	property string fileName
	source: texturePath + fileName
}
