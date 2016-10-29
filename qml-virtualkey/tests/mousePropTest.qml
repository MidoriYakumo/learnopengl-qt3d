import QtQuick 2.7
import QtQuick.Window 2.0

Window {
	id: window
	objectName: "root"
	height: 600
	width: 600

	Item {
		id: root
		objectName: "root"
		anchors.fill: parent
		height: 600
		width: 600

		Rectangle {
			id: lRect
			objectName: "lRect"
			height: parent.height
			width: parent.width / 2
			color: "coral"

			MouseArea {
				id: lMouse
				objectName: "lMouse"
				anchors.fill: parent
				onClicked: console.log(objectName)
			}
		}

		Rectangle {
			id: rRect
			objectName: "rRect"
			height: parent.height
			width: parent.width / 2
			x: parent.width / 2
			color: "teal"

			MouseArea {
				id: rMouse
				objectName: "rMouse"
				anchors.fill: parent
				onClicked: console.log(objectName)
			}
		}
	}

	MouseArea {
		id: wMouse
		anchors.fill: parent
		objectName: "wMouse"
		onClicked: {
			console.log(objectName)
			timer.defer = function() {
				t.mouseClick(lRect)
				t.mouseClick(rMouse)
				t.mouseClick(root)
				wMouse.enabled = true
			}
			enabled = false
			timer.start()
		}
	}

	TestCase {
		id: t
	}

	Timer {
		id: timer

		interval: 0

		property var defer: function(){}

		onTriggered: {
			defer()
		}
	}

}
