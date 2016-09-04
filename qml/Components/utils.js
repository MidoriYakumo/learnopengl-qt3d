.pragma library

// OK, Float32Array is half compatible
// thought Float32Array.from(array) not work, Float32Array(array) works
//function copyArray(src, dst) { // copy js list/array to gl.xxxArray
//	src.forEach(function(e, i){
//		dst[i] = e
//	})
//}

function mix(a, b, u) {
	return a*(1.-u)+b*u
}
