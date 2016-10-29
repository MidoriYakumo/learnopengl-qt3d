import QtQuick 2.7

import "."

Item {
	Component {
		id: component

		Rectangle {
			id: ripple

			property int cx: 1
			property int cy: 1
			property int size: Units.gu// * 2
			property int duration: 1000

			width: 1
			height: width
			radius: width
			x: cx-width/2
			y: cy-height/2
			opacity: (1-(width/size))*.7
			color: "skyblue"

			Behavior on width {
				NumberAnimation {
					duration: ripple.duration
				}
			}

			onOpacityChanged: {
				if (opacity <= 0)
					destroy()
			}

			Component.onCompleted: {
				width = size + 1
			}
		}
	}


	function create(x, y, par, color, size, duration) {
		var r = component.createObject(par)
		r.cx = x
		r.cy = y
		if (color)
			r.color = color
		if (size)
			r.size = size
		if (duration)
			r.duration = duration
		return r
	}
}
