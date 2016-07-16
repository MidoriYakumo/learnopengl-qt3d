.pragma library

function copyArray(src, dst) { // copy js list/array to gl.xxxArray
	for (var i in src) {
		dst[i] = src[i]
	}
}

function mix(a, b, u) {
	return a*(1.-u)+b*u
}

function testQrc(){
	try {
		return app.qrcOn; // if app exists
	}
	catch (err) {
		return false;
	}
}

function rootPrefix(){
	var os2Prefix = {
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		// Compatibility for QML Creator
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	return testQrc()?"qrc:":os2Prefix[Qt.platform.os]
}
