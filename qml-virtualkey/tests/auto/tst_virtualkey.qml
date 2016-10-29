import QtQuick 2.7
import QtTest 1.1
import QtQuick.Controls 2.0

import VirtualKey 1.0


Column {
	id: root

	TextField {
		id: text1
	}

	TextField {
		id: text2

		function aPressed(event) {
			if (event.modifiers && event.modifiers === Qt.ShiftModifier)
				text = "Nice boat!"
			else
				text = "Good job."
		}
	}

	VirtualKey {
		id: kTab
		text: "Tab"
		key: Qt.Key_Tab
		target: root
		targetHandler: null
		repeatInterval: -1
	}

	Row {
		id: vKeyRow
	}

	Component {
		id: vKey
		VirtualKey {
			text: "test"
			target: null
			targetHandler: null
			repeatInterval: -1
		}
	}

	TestCase {
		name: "VirtualKey"
		when: windowShown

		property string testString: "The quick brown fox jumps over the lazy dog"

		function test_setFocus(){
			while (!text1.focus)
				keyClick(Qt.Key_Tab)
			keyClick(Qt.Key_Tab)
			while (!text1.focus) {
				verify(!kTab.focus)
				keyClick(Qt.Key_Tab)
			}
		}

		function test_click_noTarget(){
			var control = vKey.createObject(root)
			verify(control)
			control.clicked()
			control.destroy()
		}

		function test_click_targetGetFocus(){
			var control = vKey.createObject(root)
			verify(control)
			text1.focus = false
			verify(!text1.focus)
			control.target = text1
			control.text = "0"
			control.clicked()
			verify(text1.focus)
			control.destroy()
		}

		function test_click_textOnly(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text1

			for (var i=0;i<10;i++) {
				text1.text = ""
				control.text = String.fromCharCode(
					Math.random() * 26 + 64)
				control.clicked()
				compare(text1.text, control.text)
			}

			control.destroy()
		}

		function test_click_noText(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text1
			control.text = ""

			for (var i=0;i<10;i++) {
				text1.text = ""
				control.key = Qt.Key_A + Math.random() * 26
				control.clicked()
				compare(text1.text.charCodeAt(0) - 'a'.charCodeAt(0),
						control.key- Qt.Key_A)
			}

			control.destroy()
		}

		function test_click_longText(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text1
			control.text = testString
			text1.text = ""
			control.key = Qt.Key_A + Math.random() * 26
			control.clicked()
			compare(text1.text.charCodeAt(0) - 'a'.charCodeAt(0),
						control.key- Qt.Key_A)

			control.destroy()
		}

		function test_click_handlerFirst(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text1
			control.targetHandler = text2
			control.repeatInterval = 1000
			control.text = "A"
			text1.text = ""
			text2.text = ""
			mousePress(control)
			compare(text1.text, "")
			compare(text2.text, "Good job.")

			control.destroy()
		}

		function test_click_handlerMethodNotFound(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text1
			control.targetHandler = text2
			control.text = "B"
			text1.text = ""
			text2.text = ""
			control.clicked()
			compare(text1.text, "B")
			compare(text2.text, "")

			control.destroy()
		}

		function test_click_handlerKeyEvent(){
			var control = vKey.createObject(root)
			verify(control)
			control.target = text2
			control.targetHandler = text2
			control.text = "A"
			control.repeatInterval = 1000
			control.modifiers = Qt.ShiftModifier
			text2.text = ""
			mousePress(control)
			compare(text2.text, "Nice boat!")

			control.destroy()
		}

		function test_case1(){
			vKeyRow.children = []
			var keyList = []
			var i, l = testString.length
			var control
			for (i=0;i<l;i++) {
				control = vKey.createObject(root)
				verify(control)
				control.text = testString[i]
				control.target = text1
				keyList.push(control)
			}
			vKeyRow.children = keyList

			for (i=0;i<l;i++) {
				vKeyRow.children[i].clicked()
			}

			// text1 is focused
			verify(text1.focus)
			// text1 has a fox
			compare(text1.text, testString)

			control = vKey.createObject(root)
			verify(control)
			control.target = text1
			control.modifiers = Qt.ControlModifier
			control.key = Qt.Key_A
			control.clicked() // Select all
			control.key = Qt.Key_C
			control.clicked() // Copy
			kTab.target = text1
			kTab.clicked() // Switch
			// text2 is focused
			verify(text2.focus)
			control.target = text2
			control.key = Qt.Key_V // Paste
			control.clicked()
			// text2 has a fox
			compare(text2.text, testString)

			for (i=0;i<l;i++) {
				vKeyRow.children[i].destroy()
			}
			vKeyRow.children = []
		}
	}
}

