.pragma library

function copyArray(src, dst) { // copy js list/array to gl.xxxArray
    src.forEach(function(e, i){
        dst[i] = e
    })
}

function mix(a, b, u) {
	return a*(1.-u)+b*u
}
