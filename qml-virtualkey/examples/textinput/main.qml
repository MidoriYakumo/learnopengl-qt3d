import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import VirtualKey 1.0

Window {
	visible: true
	width: Math.max(800, vkeys.centerItem.width + Units.gu * 2)
	height: 600
	title: qsTr("Text Input")


	FocusScope {
		id: root
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: vkControl.bottom
		anchors.bottom: parent.bottom

		Root {
			anchors.fill: parent
		}
	}


	Row {
		id: vkControl
		anchors.top: parent.top
		anchors.topMargin: 8
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8

		Button {
			text: vkeys.active?"↧":"↥"
			onClicked: vkeys.active = !vkeys.active
		}
		Button {
			id: toggleOverlay
			text: "overlay"
			checkable: true
		}
	}

	VirtualKeyboard {
		id: vkeys

		active: true
		target: root
		color: "#d6d7d7"
		overlay: toggleOverlay.checked
	}
}
