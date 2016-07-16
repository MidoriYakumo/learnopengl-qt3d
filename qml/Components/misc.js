.pragma library

function copyArray(src, dst) { // copy js list/array to gl.xxxArray
	for (var i in src) {
		dst[i] = src[i]
	}
}

function mix(a, b, u) {
	return a*(1.-u)+b*u
}
