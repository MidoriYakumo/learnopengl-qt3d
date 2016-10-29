import QtQuick 2.7
import QtQuick.Controls 2.0

import "."

Button {
	id: control

	text: "Unkown"

	property int key: Qt.Key_unknown
	property int modifiers: Qt.NoModifier
	property Item target: parent.target
	property var targetHandler: parent.targetHandler
	property int repeatDelay: 600
	property int repeatInterval: 40

	width: 0

	focusPolicy: Qt.NoFocus

	states: [
		State {
			name: "freeze"
			when: (control.repeatInterval<=0)||(!pressed)
			PropertyChanges {
				target: repeatTrigger
				repeat: false
				interval: 0
				running: false
			}
		},
		State {
			name: "delay"
			PropertyChanges {
				target: repeatTrigger
				repeat: false
				interval: control.repeatDelay
				running: true
				onTriggered: control.state = "repeat"
			}
		},
		State {
			name: "repeat"
			PropertyChanges {
				target: repeatTrigger
				repeat: true
				running: true
				interval: control.repeatInterval
				onTriggered: control.sendPress()
			}
		}
	]


	onPressedChanged:
		if (repeatInterval>0)
			if (pressed) {
				sendPress()
				state = "delay"
			}
			else
				sendRelease()

	onClicked:
		if (repeatInterval<=0)
			sendClick()

//	onReleased: // event missing still not fixed
//		state = "freeze"

	function sendPress() {
		//console.log("sendPress")
		if (!target)
			return;

		target.focus = true

		var done = false
		if (text) {
			if (targetHandler) {
				var t = text
				t = t.setCharAt(0, t[0].toLowerCase())
				var event = {
					"key": key,
					"modifiers": modifiers,
					"text": text
				}
				if (targetHandler[t+"Pressed"]) {
					targetHandler[t+"Pressed"](event)
					done = true
				} else if (targetHandler["pressed"]) {
					targetHandler["pressed"](event)
					done = true
				}
			}
			if (!done && text.length == 1) {
				InputEventSource.keyPressChar(text, modifiers, -1)
				done = true
			}
		}
		if (!done)
			InputEventSource.keyPress(key, modifiers, -1)
	}

	function sendRelease() {
		//console.log("sendRelease")
		if (!target)
			return;

		target.focus = true

		var done = false
		if (text) {
			if (targetHandler) {
				var t = text
				t = t.setCharAt(0, t[0].toLowerCase())
				var event = {
					"key": key,
					"modifiers": modifiers,
					"text": text
				}
				if (targetHandler["released"]) {
					targetHandler["released"](event)
					done = true
				}
			}
			if (!done && text.length == 1) {
				InputEventSource.keyReleaseChar(text, modifiers, -1)
				done = true
			}
		}
		if (!done)
			InputEventSource.keyRelease(key, modifiers, -1)
	}

	function sendClick() {
		//console.log("sendClick")
		if (!target)
			return;

		target.focus = true

		var done = false
		if (text) {
			if (targetHandler) {
				var t = text
				t = t.setCharAt(0, t[0].toLowerCase())
				var event = {
					"key": key,
					"modifiers": modifiers,
					"text": text
				}
				if (targetHandler["clicked"]) {
					targetHandler["clicked"](event)
					done = true
				}
			}
			if (!done && text.length == 1) {
				InputEventSource.keyClickChar(text, modifiers, -1)
				done = true
			}
		}
		if (!done)
			InputEventSource.keyClick(key, modifiers, -1)
	}

	Timer {
		id: repeatTrigger
	}

	Component.onCompleted: { // default: minimal size
		if (width === 0) {
			width = contentItem.paintedWidth + leftPadding + rightPadding
			height = contentItem.height + topPadding + bottomPadding
		}
	}
}
