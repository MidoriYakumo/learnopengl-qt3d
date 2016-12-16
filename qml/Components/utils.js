.pragma library

// OK, Float32Array is half compatible
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
	if(index > this.length-1) return str;
	return this.substr(0,index) + chr + this.substr(index+1);
}

var Quaternion = function () {
	var r = {
	};
	return r;
}

var Matrix3x3 = function () {
	var r = {
		fromMatrix4x4: function () {
	//		m.m11, m.m12, m.m13,
	//		m.m21, m.m22, m.m23,
	//		m.m31, m.m32, m.m33
		},
		toMatrix4x4: function () {
	//		m.m11, m.m12, m.m13,
	//		m.m21, m.m22, m.m23,
	//		m.m31, m.m32, m.m33
		}
	};
	return r;
}
