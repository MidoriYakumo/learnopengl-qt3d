.pragma library

// OK, Float32Array is partially compatible
// thought Float32Array.from(array) not work, Float32Array(array) works
//function copyArray(src, dst) { // copy js list/array to gl.xxxArray
//	src.forEach(function(e, i){
//		dst[i] = e
//	})
//}

function mix(a, b, u) {
	return a*(1.-u)+b*u;
}


String.prototype.setCharAt = function(index,chr) { // Create new String
	if(index > this.length-1) return this;
	return this.substr(0,index) + chr + this.substr(index+1);
}
