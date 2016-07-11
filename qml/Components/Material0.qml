import Qt3D.Extras 2.0

DiffuseSpecularMapMaterial {
	id: objMaterial
	//ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )

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

	property string diffuseName
	property string specularName

	diffuse: texturePath + diffuseName
	specular: texturePath + specularName
}
