import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

import VirtualKey 1.0

Item {
	id: window
	objectName: "window"
	width: 800
	height: 600

	Column {
		id: root
		objectName: "root"
		anchors.centerIn: parent

		padding: 8
		spacing: 8

		RangeSlider {
			id: s2
			objectName: "s2"
		}

		RadioButton {
			id: r1
			objectName: "r1"
			text: objectName
		}

		Button {
			id: b1
			objectName: "b1"
			text: objectName
		}

		RadioButton {
			id: r2
			objectName: "r2"
			text: objectName
		}

		Button {
			id: b2
			objectName: "b2"
			text: objectName
		}

		RadioButton {
			id: r3
			objectName: "r3"
			text: objectName
		}

		RangeSlider {
			id: s1
			objectName: "s1"
		}

		ButtonGroup {
			id: group
			buttons: [r1, r2, r3]
		}
	}

	Item {
		id: free
		objectName: "free"
		anchors.fill: parent

		Rectangle {
			id: o1
			objectName: "o1"
			height: 200
			width: height
			color: "khaki"
			x: 8
			y: 8

			MouseArea {
				anchors.fill: parent
				drag.target: parent
			}
		}

		Rectangle {
			id: o2
			objectName: "o2"
			height: 200
			width: height
			color: "plum"
			x: parent.width - width - 8
			y: parent.height - height - 8

			MouseArea {
				anchors.fill: parent
				drag.target: parent
			}
		}
	}

	MutitouchDispatcher {
		stickAndDrag: false
		simulateDrag: true
		accumulateDrag: true
		touchVisualize: true
	}

}
