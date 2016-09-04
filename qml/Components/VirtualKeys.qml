import QtQuick 2.7
import QtQuick.Controls 2.0

Item  {
	anchors.fill: parent
	visible: true //["android", "ios"].indexOf(Qt.platform.os)>=0

	property alias target: row.target
	property var targetHandler: null
	property bool showPad: true
	property var keys:[
//		{text:"Tab", key:Qt.Key_Tab},
//		{text:"Space", key:Qt.Key_Space},
//		{text:"Up", key:Qt.Key_Up}
	]

	Row {
		id: row

		property Item target: scene

		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: showPad?virtualpad.width/2:0
		anchors.margins: 8
		spacing: 8

		Repeater {
			model: keys
			delegate: VirtualKey {
				target: parent.target
				targetHandler: parent.targetHandler
				text: modelData.text
				key: modelData.key
			}
		}
	}

	VirtualPad {
		id: virtualpad
		visible: showPad
		height: 200
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.margins: 8
		target: parent.target
		targetHandler: parent.targetHandler
	}

	Component.onCompleted: {
		console.log("VirtualKeys.targetHandler:", targetHandler)
	}
}
