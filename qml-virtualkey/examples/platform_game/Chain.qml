import QtQuick 2.7

import VirtualKey 1.0

Item {
	id: root

	anchors.centerIn: man

	opacity:  Math.abs(ex+ey)/2/man.width

	property Item man
	property int count: 6
	property real radius: man.width / 3
	property real ex: 0
	property real ey: 0

	Repeater {
		model: root.count
		delegate: Rectangle {
			width: index?root.radius/2:root.radius
			height: width
			radius: width/2
			x: -width/2 + root.ex*(1-index/root.count)
			y: -height/2 + root.ey*(1-index/root.count)
			color: "white"
		}
	}
}
