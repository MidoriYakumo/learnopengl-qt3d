.pragma library

function getElementByCriteria(root, criteria) {
	var r = []
	for (var i in root.children) {
		var child = root.children[i]
		if (criteria(child))
			r.push(child)
		r = r.concat(getElementByCriteria(child, criteria))
	}
	return r
}
