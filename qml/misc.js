.pragma library

function copyArray(src, dst) {
	for (var i in src) {
		dst[i] = src[i]
	}
}

/*
function testId(n) {
	try {
		return n;
	}
	catch (err) {
		return null;
	}
}
*/
