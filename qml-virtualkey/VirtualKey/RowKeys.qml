import QtQuick 2.7

import "."

Row {
	id: row

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property int modifiers: parent.modifiers

	property var keys:[
		{text:"X"},
		{text:"Shift", key:Qt.Key_Shift/*, hold:true*/},
		{text:"Space", key:Qt.Key_Space, modifiers: Qt.ControlModifier}
	]

	anchors.bottom: parent.bottom
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.margins: Units.dp * 8
	spacing: Units.dp * 8

	Repeater {
		model: row.keys
		delegate: VirtualKey {
			target: row.target
			targetHandler: row.targetHandler
			text: modelData.text
			key: (modelData["key"]===undefined)?
					 0:modelData.key
			modifiers: (modelData["modifiers"]===undefined)?
						  row.modifiers:modelData.modifiers
		}
	}
}
