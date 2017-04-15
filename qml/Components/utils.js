.pragma library

String.prototype.setCharAt = function(index,chr) { // Create new String
	if(index > this.length-1) return this;
	return this.substr(0, index) + chr + this.substr(index + 1);
}
