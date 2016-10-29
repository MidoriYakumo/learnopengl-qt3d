import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import VirtualKey 1.0

Window {
	visible: true
	width: 800
	height: 600
	title: qsTr("Qastlevania")


	FocusScope {
		id: root
		focus: true
		anchors.fill: parent
		Root {
			anchors.fill: parent
		}
	}


	VirtualKeys {
		id: vkeys

		active: true
		target: root
		color: "transparent"
	}
}
