.pragma library
//'use strict'

var EPS = 1e-9;
var EPS2 = 1e-6;
var EPS3 = 1e-3;
var DECIMALS = 4;

function zero(x) {
	return Math.abs(x) <= EPS;
}

function zero2(x) {
	return Math.abs(x) <= EPS2;
}

function zero3(x) {
	return Math.abs(x) <= EPS3;
}

function clamp(v, l, h) {
	return (v<l)?l:(v>h)?h:v;
}

function mix(a, b, u) {
	return a*(1. - u) + b * u;
}

function deg2rad(deg) {
	return deg * Math.PI / 180;
}

function rad2deg(rad) {
	return rad * 180 / Math.PI;
}

var Vector2D = function(x, y) {
	this._ = Qt.vector2d(x, y);
}

var Vector3D = function(x, y, z) {
	this._ = Qt.vector3d(x, y, z);
}

var Vector4D = function(x, y, z, w) {
	this._ = Qt.vector4d(x, y, z, w);
}

var Matrix4x4 = function(
	m11, m12, m13, m14,
	m21, m22, m23, m24,
	m31, m32, m33, m34,
	m41, m42, m43, m44
) {
	this._ = Qt.matrix4x4(
		m11, m12, m13, m14,
		m21, m22, m23, m24,
		m31, m32, m33, m34,
		m41, m42, m43, m44
	);
}

var Quaternion = function(w, x, y, z) {
	this.w = w || 0;
	this.x = x || 0;
	this.y = y || 0;
	this.z = z || 0;
}

Object.defineProperty(Vector2D.prototype, "x", {
	get: function () { return this._.x; },
	set: function (x) { this._.x = x; },
});

Object.defineProperty(Vector2D.prototype, "y", {
	get: function () { return this._.y; },
	set: function (y) { this._.y = y; },
});

Object.defineProperty(Vector2D.prototype, "r", {
	get: function () { return Math.sqrt(this._.x*this._.x+this._.y*this._.y); },
});

Object.defineProperty(Vector2D.prototype, "theta", {
	get: function () { return Math.atan2(this._.y, this._.x); },
});

Object.defineProperty(Vector3D.prototype, "x", {
	get: function () { return this._.x; },
	set: function (x) { this._.x = x; },
});

Object.defineProperty(Vector3D.prototype, "y", {
	get: function () { return this._.y; },
	set: function (y) { this._.y = y; },
});

Object.defineProperty(Vector3D.prototype, "z", {
	get: function () { return this._.z; },
	set: function (z) { this._.z = z; },
});

Object.defineProperty(Vector4D.prototype, "x", {
	get: function () { return this._.x; },
	set: function (x) { this._.x = x; },
});

Object.defineProperty(Vector4D.prototype, "y", {
	get: function () { return this._.y; },
	set: function (y) { this._.y = y; },
});

Object.defineProperty(Vector4D.prototype, "z", {
	get: function () { return this._.z; },
	set: function (z) { this._.z = z; },
});

Object.defineProperty(Vector4D.prototype, "w", {
	get: function () { return this._.w; },
	set: function (w) { this._.w = w; },
});

Object.defineProperty(Matrix4x4.prototype, "m11", {
	get: function () { return this._.m11; },
	set: function (m11) { this._.m11 = m11; },
});

Object.defineProperty(Matrix4x4.prototype, "m12", {
	get: function () { return this._.m12; },
	set: function (m12) { this._.m12 = m12; },
});

Object.defineProperty(Matrix4x4.prototype, "m13", {
	get: function () { return this._.m13; },
	set: function (m13) { this._.m13 = m13; },
});

Object.defineProperty(Matrix4x4.prototype, "m14", {
	get: function () { return this._.m14; },
	set: function (m14) { this._.m14 = m14; },
});

Object.defineProperty(Matrix4x4.prototype, "m21", {
	get: function () { return this._.m21; },
	set: function (m21) { this._.m21 = m21; },
});

Object.defineProperty(Matrix4x4.prototype, "m22", {
	get: function () { return this._.m22; },
	set: function (m22) { this._.m22 = m22; },
});

Object.defineProperty(Matrix4x4.prototype, "m23", {
	get: function () { return this._.m23; },
	set: function (m23) { this._.m23 = m23; },
});

Object.defineProperty(Matrix4x4.prototype, "m24", {
	get: function () { return this._.m24; },
	set: function (m24) { this._.m24 = m24; },
});

Object.defineProperty(Matrix4x4.prototype, "m31", {
	get: function () { return this._.m31; },
	set: function (m31) { this._.m31 = m31; },
});

Object.defineProperty(Matrix4x4.prototype, "m32", {
	get: function () { return this._.m32; },
	set: function (m32) { this._.m32 = m32; },
});

Object.defineProperty(Matrix4x4.prototype, "m33", {
	get: function () { return this._.m33; },
	set: function (m33) { this._.m33 = m33; },
});

Object.defineProperty(Matrix4x4.prototype, "m34", {
	get: function () { return this._.m34; },
	set: function (m34) { this._.m34 = m34; },
});

Object.defineProperty(Matrix4x4.prototype, "m41", {
	get: function () { return this._.m41; },
	set: function (m41) { this._.m41 = m41; },
});

Object.defineProperty(Matrix4x4.prototype, "m42", {
	get: function () { return this._.m42; },
	set: function (m42) { this._.m42 = m42; },
});

Object.defineProperty(Matrix4x4.prototype, "m43", {
	get: function () { return this._.m43; },
	set: function (m43) { this._.m43 = m43; },
});

Object.defineProperty(Matrix4x4.prototype, "m44", {
	get: function () { return this._.m44; },
	set: function (m44) { this._.m44 = m44; },
});

Vector2D.prototype.toString = function() {
	return "(%1, %2)".arg(this.x).arg(this.y);
}

Vector3D.prototype.toString = function() {
	return "(%1, %2, %3)".arg(this._.x).arg(this._.y).arg(this._.z);
}

Vector4D.prototype.toString = function() {
	return "(%1, %2, %3, %4)".arg(this._.x).arg(this._.y).arg(this._.z)
		.arg(this._.w);
}

Quaternion.prototype.toString = function() {
	return "[%1 (%2, %3, %4)]".arg(this.w)
		.arg(this.x).arg(this.y).arg(this.z);
}

Matrix4x4.prototype.toString = function() {
	return "[[%1 %2 %3 %4]\n[%5 %6 %7 %8]\n[%9 %10 %11 %12]\n[%13 %14 %15 %16]]"
		.arg(this._.m11).arg(this._.m12).arg(this._.m13).arg(this._.m14)
		.arg(this._.m21).arg(this._.m22).arg(this._.m23).arg(this._.m24)
		.arg(this._.m31).arg(this._.m32).arg(this._.m33).arg(this._.m34)
		.arg(this._.m41).arg(this._.m42).arg(this._.m43).arg(this._.m44);
}

Vector2D.prototype.all = function(n) {
	this._.x = n;
	this._.y = n;
	return this;
}

Vector2D.prototype.zeros = function() {
	return this.all(0);
}

Vector2D.prototype.ones = function() {
	return this.all(1);
}

Vector2D.prototype.randomUnit = function() {
	var a = Math.random() * Math.PI * 2;
	this._.x = Math.cos(a);
	this._.y = Math.sin(a);
	return this;
}

Vector2D.prototype.fromArray = function(array) {
	if (Array.isArray(array)) {
		this._.x = array[0] || 0;
		this._.y = array[1] || 0;
	}

	return this;
}

Vector2D.prototype.clone = function() {
	return new Vector2D(this._.x, this._.y);
}

Vector2D.prototype.zero = function() {
	return zero2(this._.x) && zero2(this._.y);
}

Vector2D.prototype.plus = function(b) {
	return new Vector2D(this._.x + b.x, this._.y + b.y);
}

Vector2D.prototype.minus = function(b) {
	return new Vector2D(this._.x - b.x, this._.y - b.y);
}

Vector2D.prototype.times = function(b) {
	return new Vector2D(this._.x * b, this._.y * b);
}

Vector2D.prototype.dotProduct = function(b) {
	return this._.x * b.x + this._.y * b.y;
}

Vector2D.prototype.crossProduct = function(b) {
	return this._.x * b.y - this._.y * b.x;
}

Vector2D.prototype.length2 = function() {
	return this.dotProduct(this);
}

Vector2D.prototype.length = function() {
	return Math.sqrt(this.length2());
}

Vector2D.prototype.area = function(b) {
	return Math.abs(this.crossProduct(b));
}

Vector2D.prototype.normalized = function(b) {
	var l = this.length();
	if (zero2(l))
		return this.clone();
	else
		return this.times(1. / l);
}

Vector2D.prototype.projectTo = function(axis, o) {
	if (o === undefined)
		o = new Vector2D().zeros();

	var uaxis = axis.normalized();
	return uaxis.times(uaxis.dotProduct(this.minus(o))).plus(o);
}

Vector2D.prototype.distanceTo = function(p0, p1) {
	if (p1 === undefined)
		return this.minus(p0).length();
	else
		return p0.minus(this).area(p1.minus(this)) / (p0.minus(p1).length());
}

Vector2D.prototype.toQtType = function() {
	return this._
}

Vector3D.prototype.clone = function() {
	return new Vector3D(this._.x, this._.y, this._.z);
}

Vector3D.prototype.zero = function() {
	return zero2(this._.x) && zero2(this._.y) && zero2(this._.z);
}

Vector3D.prototype.plus = function(b) {
	return new Vector3D(this._.x + b.x, this._.y + b.y, this._.z + b.z);
}

Vector3D.prototype.minus = function(b) {
	return new Vector3D(this._.x - b.x, this._.y - b.y, this._.z - b.z);
}

Vector3D.prototype.times = function(b) {
	return new Vector3D(this._.x * b, this._.y * b, this._.z * b);
}

Vector3D.prototype.dotProduct = function(b) {
	return this._.x * b.x + this._.y * b.y + this._.z * b.z;
}

Vector3D.prototype.crossProduct = function(b) {
	return new Vector3D(
		this._.y * b.z - this._.z * b.y,
		this._.z * b.x - this._.x * b.z,
		this._.x * b.y - this._.y * b.x
	);
}

Vector3D.prototype.length2 = function() {
	return this.dotProduct(this);
}

Vector3D.prototype.length = function() {
	return Math.sqrt(this.length2());
}

Vector3D.prototype.area = function(b) {
	return this.crossProduct(b).length();
}

Vector3D.prototype.normalized = function(b) {
	var l = this.length();
	if (zero2(l))
		return this.clone();
	else
		return this.times(1. / l);
}

Vector3D.prototype.toQtType = function() {
	return this._
}

Vector4D.prototype.toQtType = function() {
	return this._
}

Matrix4x4.prototype.toQtType = function() {
	return this._
}

Quaternion.prototype.clone = function() {
	return new Quaternion(this.w, this.x, this.y, this.z);
}

Quaternion.prototype.fromWAndVector = function(ow, ov) {
	this.w = ow;
	this.x = ov.x;
	this.y = ov.y;
	this.z = ov.z;
	return this;
}

Quaternion.prototype.rotationTo = function(from, to) {
	var vf = from.normalized();
	var vt = to.normalized();
	var d = vf.dotProduct(vt) + 1.;
	var axis;

	if (zero2(d)) {
		axis = Qt.vector3d(1, 0, 0).crossProduct(vf);
		if (zero2(axis.length2()))
			axis = Qt.vector3d(0, 1, 0).crossProduct(vf);
		axis = axis.normalized();

		return this.fromWAndVector(0, axis);
	}

	d = Math.sqrt(d * 2);
	axis = vf.crossProduct(vt).times(1. / d);

	return this.fromWAndVector(d / 2, axis);
}

Quaternion.prototype.isIdentity = function() {
	return this.w === 1 && this.x === 0 && this.y === 0 && this.z === 0;
}

Quaternion.prototype.conjugated = function() {
	return new Quaternion(this.w, -this.x, -this.y, -this.z);
}

Quaternion.prototype.scalar = function() {
	return this.w;
}

Quaternion.prototype.vector = function() {
	return new Vector3D(this.x, this.y, this.z);
}

Quaternion.prototype.toMatrix = function() {
	var f2x = this.x + this.x;
	var f2y = this.y + this.y;
	var f2z = this.z + this.z;
	var f2xw = f2x * this.w;
	var f2yw = f2y * this.w;
	var f2zw = f2z * this.w;
	var f2xx = f2x * this.x;
	var f2xy = f2x * this.y;
	var f2xz = f2x * this.z;
	var f2yy = f2y * this.y;
	var f2yz = f2y * this.z;
	var f2zz = f2z * this.z;

	return new Matrix4x4(
		1. - (f2yy + f2zz), f2xy - f2zw, f2xz + f2yw, 0,
		f2xy + f2zw, 1. - (f2xx + f2zz), f2yz - f2xw, 0,
		f2xz - f2yw, f2yz + f2xw, 1. - (f2xx + f2yy), 0,
		0, 0, 0, 1
	);
}

Quaternion.prototype.times = function(b) {
	var yy = (this.w - this.y) * (b.w + b.z);
	var zz = (this.w + this.y) * (b.w - b.z);
	var ww = (this.z + this.x) * (b.x + b.y);
	var xx = ww + yy + zz;
	var qq = .5 * (xx + (this.z - this.x) * (b.x - b.y));

	var rw = qq - ww + (this.z - this.y) * (b.y - b.z);
	var rx = qq - xx + (this.x + this.w) * (b.x + b.w);
	var ry = qq - yy + (this.w - this.x) * (b.y + b.z);
	var rz = qq - zz + (this.z + this.y) * (b.w - b.x);

	rw = clamp(rw, 0, 1); // precision !

	return new Quaternion(rw, rx, ry, rz);
}

Quaternion.prototype.dotProduct = function(b) {
	return new Quaternion(
		this.w * b.w, this.x * b.x, this.y * b.y, this.z * b.z
	);
}

Quaternion.prototype.rotated = function(from) {
	return this.times(new Quaternion().fromWAndVector(0, from))
		.times(this.conjugated()).vector()
		.normalized().times(from.length());
}

//////////////// test ///////////////////////

var Matrix3x3 = function (
	m11, m12, m13,
	m21, m22, m23,
	m31, m32, m33
) {
	var _m11, _m12, _m13;
	var _m21, _m22, _m23;
	var _m31, _m32, _m33;
	_m11 = m11 === undefined?1:m11;
	_m12 = m12 === undefined?0:m12;
	_m13 = m13 === undefined?0:m13;
	_m21 = m21 === undefined?0:m21;
	_m22 = m22 === undefined?1:m22;
	_m23 = m23 === undefined?0:m23;
	_m31 = m31 === undefined?0:m31;
	_m32 = m32 === undefined?0:m32;
	_m33 = m33 === undefined?1:m33;
	var r = {
		m11: _m11, m12: _m12, m13: _m13,
		m21: _m21, m22: _m22, m23: _m23,
		m31: _m31, m32: _m32, m33: _m33,
		toString: function() {
			return "[[%1 \t%2 \t%3]\n [%4 \t%5 \t%6]\n [%7 \t%8 \t%9]]"
				.arg(this.m11).arg(this.m12).arg(this.m13)
				.arg(this.m21).arg(this.m22).arg(this.m23)
				.arg(this.m31).arg(this.m32).arg(this.m33)
			;
		},
		fromMatrix4x4: function (other) {
			this.m11 = other.m11; this.m12 = other.m12; this.m13 = other.m13;
			this.m21 = other.m21; this.m22 = other.m22; this.m23 = other.m23;
			this.m31 = other.m31; this.m32 = other.m32; this.m33 = other.m33;
			return this;
		},
		toMatrix4x4: function () {
			return Qt.matrix4x4(
				this.m11, this.m12, this.m13, 0,
				this.m21, this.m22, this.m23, 0,
				this.m31, this.m32, this.m33, 0,
				0, 0, 0, 1
			);
		},
	};
	return r;
};

//class Point3D {
//	constructor(x, y, z) {
//		this._x = x;
//		this._y = y;
//		this._z = z;
//	}

//	static all(n) {
//		return new Point3D(n, n, n);
//	}

//	static zeros() {
//		return all(0);
//	}

//	static ones() {
//		return all(1);
//	}

//	static fromArray(array) {
//		let x = 0;
//		let y = 0;
//		let z = 0;

//		if (Array.isArray(array)) {
//			x = array[0] ? array[0] : 0;
//			y = array[1] ? array[1] : 0;
//			z = array[2] ? array[2] : 0;
//		}

//		return new Point3D(x, y, z);
//	}

//	static randomUnit() {
//		let a = Math.random() * Math.PI * 2;
//		let b = Math.random() * Math.PI * 2;
//		return new Point3D(Math.cos(a)*Math.cos(b), Math.cos(a)*Math.sin(b), Math.sin(a));
//	}

//	clone() {
//		return new Point3D(this._x, this._y, this._z);
//	}

//	toString() {
//		let p = DECIMALS + 1;
//		return `[${this._x.toPrecision(p)}, \t${this._y.toPrecision(p)}, \t${this._z.toPrecision(p)}]`;
//	}

//	get x() {
//		return this._x;
//	}

//	get y() {
//		return this._y;
//	}

//	get z() {
//		return this._z;
//	}

//	zero() {
//		return zero2(this._x) && zero2(this._y) && zero2(this._z);
//	}

//	plus(p) {
//		return new Point3D(this._x + p.x, this._y + p.y, this._z + p.z);
//	}

//	minus(p) {
//		return new Point3D(this._x - p.x, this._y - p.y, this._z - p.z);
//	}

//	times(p) {
//		if (Number.isFinite(p))
//			return new Point3D(this._x * p, this._y * p, this._z * p);
//		else
//			return new Point3D(this._x * p.x, this._y * p.y, this._z * p.z);
//	}

//	dot(p) {
//		return this._x * p.x + this._y * p.y + this._z * p.z;
//	}

//	cross(p) {
//		return new Point3D(
//			this._y * p.z - this._z * p.y,
//			this._z * p.x - this._x * p.z,
//			this._x * p.y - this._y * p.x
//		);
//	}

//	length2() {
//		return this.dot(this);
//	}

//	length() {
//		return Math.sqrt(this.length2());
//	}

//	area(p) {
//		return this.cross(p).length();
//	}

//	normalized() {
//		let l = this.length();
//		if (zero(l))
//			return clone();
//		else
//			return this.times(1. / l);
//	}

//	projectTo(p, o) {
//		if (o === undefined)
//			o = Point3D.zeros();

//		let u = p.normalized();
//		return u.times(u.dot(this.minus(o))).plus(o);
//	}

//	distanceTo(p0, p1) {
//		if (p1 === undefined)
//			return this.minus(p0).length();
//		else
//			return p0.minus(this).area(p1.minus(this)) / (p0.minus(p1).length());
//	}

//	inTriCylinder(p0, p1, p2, h, l) {
//		if (h === undefined)
//			h = 5e-2;
//		if (l === undefined)
//			l = -5e-2;

//		let e0 = p0.minus(p2);
//		let e1 = p1.minus(p0);
//		let e2 = p2.minus(p1);
//		let normal = e1.cross(e0.times(-1)).normalized();
//		let distance = this.minus(p0).dot(normal);

//		if (!(l <= distance && distance <= h))
//			return false;

//		if (e0.cross(this.minus(p2)).dot(normal) < 0 ||
//				e1.cross(this.minus(p0)).dot(normal) < 0 ||
//				e2.cross(this.minus(p1)).dot(normal) < 0 )
//			return false;

//		return true;
//	}
//}

//class Matrix4x4 {
//	constructor(
//		m11, m12, m13, m14,
//		m21, m22, m23, m24,
//		m31, m32, m33, m34,
//		m41, m42, m43, m44
//	) {
//		this._m11 = m11; this._m12 = m12; this._m13 = m13; this._m14 = m14;
//		this._m21 = m21; this._m22 = m22; this._m23 = m23; this._m24 = m24;
//		this._m31 = m31; this._m32 = m32; this._m33 = m33; this._m34 = m34;
//		this._m41 = m41; this._m42 = m42; this._m43 = m43; this._m44 = m44;
//	}

//	static all(n) {
//		return new Matrix4x4(
//			n, n, n, n,
//			n, n, n, n,
//			n, n, n, n,
//			n, n, n, n
//		);
//	}

//	static zeros() {
//		return all(0);
//	}

//	static ones() {
//		return all(1);
//	}

//	static diag() {
//		return new Matrix4x4(
//			1, 0, 0, 0,
//			0, 1, 0, 0,
//			0, 0, 1, 0,
//			0, 0, 0, 1
//		);
//	}

//	get m11() { return this._m11; }
//	get m12() { return this._m12; }
//	get m13() { return this._m13; }
//	get m14() { return this._m14; }
//	get m21() { return this._m21; }
//	get m22() { return this._m22; }
//	get m23() { return this._m23; }
//	get m24() { return this._m24; }
//	get m31() { return this._m31; }
//	get m32() { return this._m32; }
//	get m33() { return this._m33; }
//	get m34() { return this._m34; }
//	get m41() { return this._m41; }
//	get m42() { return this._m42; }
//	get m43() { return this._m43; }
//	get m44() { return this._m44; }

//	clone() {
//		return new Matrix4x4(
//			this._m11, this._m12, this._m13, this._m14,
//			this._m21, this._m22, this._m23, this._m24,
//			this._m31, this._m32, this._m33, this._m34,
//			this._m41, this._m42, this._m43, this._m44
//		);
//	}

//	toString() {
//		let p = DECIMALS + 1;
//		let r = "[";
//		r += `[${this._m11.toPrecision(p)}, \t${this._m12.toPrecision(p)}, \t${this._m13.toPrecision(p)}, \t${this._m14.toPrecision(p)}]\n`;
//		r += `[${this._m21.toPrecision(p)}, \t${this._m22.toPrecision(p)}, \t${this._m23.toPrecision(p)}, \t${this._m24.toPrecision(p)}]\n`;
//		r += `[${this._m31.toPrecision(p)}, \t${this._m32.toPrecision(p)}, \t${this._m33.toPrecision(p)}, \t${this._m34.toPrecision(p)}]\n`;
//		r += `[${this._m41.toPrecision(p)}, \t${this._m42.toPrecision(p)}, \t${this._m43.toPrecision(p)}, \t${this._m44.toPrecision(p)}]]`;
//		return r;
//	}

//	toArray() {
//		return new Array(
//			this._m11, this._m12, this._m13, this._m14,
//			this._m21, this._m22, this._m23, this._m24,
//			this._m31, this._m32, this._m33, this._m34,
//			this._m41, this._m42, this._m43, this._m44
//		);
//	}

//	zero() {
//		return zero2(this._x) && zero2(this._y) && zero2(this._z);
//	}

//	times(b) {
//		return new Matrix4x4(
//			this._m11 * b.m11 + this._m12 * b.m21 + this._m13 * b.m31 + this._m14 * b.m41,
//			this._m11 * b.m12 + this._m12 * b.m22 + this._m13 * b.m32 + this._m14 * b.m42,
//			this._m11 * b.m13 + this._m12 * b.m23 + this._m13 * b.m33 + this._m14 * b.m43,
//			this._m11 * b.m14 + this._m12 * b.m24 + this._m13 * b.m34 + this._m14 * b.m44,
//			this._m21 * b.m11 + this._m22 * b.m21 + this._m23 * b.m31 + this._m24 * b.m41,
//			this._m21 * b.m12 + this._m22 * b.m22 + this._m23 * b.m32 + this._m24 * b.m42,
//			this._m21 * b.m13 + this._m22 * b.m23 + this._m23 * b.m33 + this._m24 * b.m43,
//			this._m21 * b.m14 + this._m22 * b.m24 + this._m23 * b.m34 + this._m24 * b.m44,
//			this._m31 * b.m11 + this._m32 * b.m21 + this._m33 * b.m31 + this._m34 * b.m41,
//			this._m31 * b.m12 + this._m32 * b.m22 + this._m33 * b.m32 + this._m34 * b.m42,
//			this._m31 * b.m13 + this._m32 * b.m23 + this._m33 * b.m33 + this._m34 * b.m43,
//			this._m31 * b.m14 + this._m32 * b.m24 + this._m33 * b.m34 + this._m34 * b.m44,
//			this._m41 * b.m11 + this._m42 * b.m21 + this._m43 * b.m31 + this._m44 * b.m41,
//			this._m41 * b.m12 + this._m42 * b.m22 + this._m43 * b.m32 + this._m44 * b.m42,
//			this._m41 * b.m13 + this._m42 * b.m23 + this._m43 * b.m33 + this._m44 * b.m43,
//			this._m41 * b.m14 + this._m42 * b.m24 + this._m43 * b.m34 + this._m44 * b.m44
//		);
//	}

//	determinant() {
//		return this._m11*this._m22*this._m33*this._m44 - this._m11*this._m22*this._m34*this._m43 + this._m11*this._m23*this._m34*this._m42 - this._m11*this._m23*this._m32*this._m44
//			+  this._m11*this._m24*this._m32*this._m43 - this._m11*this._m24*this._m33*this._m42 - this._m12*this._m23*this._m34*this._m41 + this._m12*this._m23*this._m31*this._m44
//			-  this._m12*this._m24*this._m31*this._m43 + this._m12*this._m24*this._m33*this._m41 - this._m12*this._m21*this._m33*this._m44 + this._m12*this._m21*this._m34*this._m43
//			+  this._m13*this._m24*this._m31*this._m42 - this._m13*this._m24*this._m32*this._m41 + this._m13*this._m21*this._m32*this._m44 - this._m13*this._m21*this._m34*this._m42
//			+  this._m13*this._m22*this._m34*this._m41 - this._m13*this._m22*this._m31*this._m44 - this._m14*this._m21*this._m32*this._m43 + this._m14*this._m21*this._m33*this._m42
//			-  this._m14*this._m22*this._m33*this._m41 + this._m14*this._m22*this._m31*this._m43 - this._m14*this._m23*this._m31*this._m42 + this._m14*this._m23*this._m32*this._m41;
//	}

//	inverted() {
//		let det = this.determinant();
//		if (zero2(det))
//			return Matrix4x4.all(NaN);
//		let invdet = 1. / det;
//		return new Matrix4x4(
//			invdet  * (this._m22 * (this._m33 * this._m44 - this._m34 * this._m43) + this._m23 * (this._m34 * this._m42 - this._m32 * this._m44) + this._m24 * (this._m32 * this._m43 - this._m33 * this._m42)),
//			-invdet * (this._m12 * (this._m33 * this._m44 - this._m34 * this._m43) + this._m13 * (this._m34 * this._m42 - this._m32 * this._m44) + this._m14 * (this._m32 * this._m43 - this._m33 * this._m42)),
//			invdet  * (this._m12 * (this._m23 * this._m44 - this._m24 * this._m43) + this._m13 * (this._m24 * this._m42 - this._m22 * this._m44) + this._m14 * (this._m22 * this._m43 - this._m23 * this._m42)),
//			-invdet * (this._m12 * (this._m23 * this._m34 - this._m24 * this._m33) + this._m13 * (this._m24 * this._m32 - this._m22 * this._m34) + this._m14 * (this._m22 * this._m33 - this._m23 * this._m32)),
//			-invdet * (this._m21 * (this._m33 * this._m44 - this._m34 * this._m43) + this._m23 * (this._m34 * this._m41 - this._m31 * this._m44) + this._m24 * (this._m31 * this._m43 - this._m33 * this._m41)),
//			invdet  * (this._m11 * (this._m33 * this._m44 - this._m34 * this._m43) + this._m13 * (this._m34 * this._m41 - this._m31 * this._m44) + this._m14 * (this._m31 * this._m43 - this._m33 * this._m41)),
//			-invdet * (this._m11 * (this._m23 * this._m44 - this._m24 * this._m43) + this._m13 * (this._m24 * this._m41 - this._m21 * this._m44) + this._m14 * (this._m21 * this._m43 - this._m23 * this._m41)),
//			invdet  * (this._m11 * (this._m23 * this._m34 - this._m24 * this._m33) + this._m13 * (this._m24 * this._m31 - this._m21 * this._m34) + this._m14 * (this._m21 * this._m33 - this._m23 * this._m31)),
//			invdet  * (this._m21 * (this._m32 * this._m44 - this._m34 * this._m42) + this._m22 * (this._m34 * this._m41 - this._m31 * this._m44) + this._m24 * (this._m31 * this._m42 - this._m32 * this._m41)),
//			-invdet * (this._m11 * (this._m32 * this._m44 - this._m34 * this._m42) + this._m12 * (this._m34 * this._m41 - this._m31 * this._m44) + this._m14 * (this._m31 * this._m42 - this._m32 * this._m41)),
//			invdet  * (this._m11 * (this._m22 * this._m44 - this._m24 * this._m42) + this._m12 * (this._m24 * this._m41 - this._m21 * this._m44) + this._m14 * (this._m21 * this._m42 - this._m22 * this._m41)),
//			-invdet * (this._m11 * (this._m22 * this._m34 - this._m24 * this._m32) + this._m12 * (this._m24 * this._m31 - this._m21 * this._m34) + this._m14 * (this._m21 * this._m32 - this._m22 * this._m31)),
//			-invdet * (this._m21 * (this._m32 * this._m43 - this._m33 * this._m42) + this._m22 * (this._m33 * this._m41 - this._m31 * this._m43) + this._m23 * (this._m31 * this._m42 - this._m32 * this._m41)),
//			invdet  * (this._m11 * (this._m32 * this._m43 - this._m33 * this._m42) + this._m12 * (this._m33 * this._m41 - this._m31 * this._m43) + this._m13 * (this._m31 * this._m42 - this._m32 * this._m41)),
//			-invdet * (this._m11 * (this._m22 * this._m43 - this._m23 * this._m42) + this._m12 * (this._m23 * this._m41 - this._m21 * this._m43) + this._m13 * (this._m21 * this._m42 - this._m22 * this._m41)),
//			invdet  * (this._m11 * (this._m22 * this._m33 - this._m23 * this._m32) + this._m12 * (this._m23 * this._m31 - this._m21 * this._m33) + this._m13 * (this._m21 * this._m32 - this._m22 * this._m31))
//		);
//	}
//}
