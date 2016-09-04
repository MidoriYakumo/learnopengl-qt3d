import QtQuick 2.7
import QtQuick.Controls 2.0

import "."

Button {
	text: "Tab"

	property int key: Qt.Key_Tab
	property int modifier: Qt.NoModifier
	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	focusPolicy: Qt.NoFocus
	onClicked: {
		target.focus = true
		if (text && targetHandler) {
			var t = text
			t[0] = t[0].toLowerCase()
			targetHandler[t+"Pressed"]()
		} else {
			if (text && text.length == 1) {
				KeyEventSource.keyClickChar(text, modifier, -1)
			} else {
				KeyEventSource.keyClick(key, modifier, -1)
			}
		}
	}

//	onPressed: {
//		posX = mouseX
//		posY = mouseY
//		trigger.start()
//	}

	Component.onCompleted: {
		height = contentItem.height + topPadding + bottomPadding
		width = contentItem.paintedWidth + leftPadding + rightPadding
	}
}
