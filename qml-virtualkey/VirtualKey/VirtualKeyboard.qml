import QtQuick 2.7

import "."

VirtualKeys {
	id: control

	enablePad: false
	enableGameButtons: false

	property int keyWidth: Units.gu// / 2
	property int keySpacing: Units.dp * 3

	modifiers: d.shiftModifier | d.otherModifiers

	QtObject {
		id: d

		property int shiftModifier: shiftKey.checked?Qt.ShiftModifier:Qt.NoModifier
		property int otherModifiers:
			controlKey.checked?Qt.ControlModifier:Qt.NoModifier |
			alterKey.checked?Qt.AltModifier:Qt.NoModifier
	}

	centerItem: Column {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		spacing: control.keySpacing

		Row {
			id: row0
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"!":"1"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"@":"2"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"#":"3"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"$":"4"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"%":"5"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"^":"6"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"&":"7"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"*":"8"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"(":"9"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?")":"0"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ⬅ "
				key: Qt.Key_Backspace
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
			}
		}

		Row {
			id: row1
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ↹ "
				key: Qt.Key_Tab
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Q":"q"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"W":"w"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"E":"e"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"R":"r"
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"T":"t"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Y":"y"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"U":"u"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"I":"i"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"O":"o"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"P":"p"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				id: alterKey
				target: control.target
				targetHandler: null
				text: "Alt"
				key: Qt.Key_Alt
				width: control.keyWidth
				checkable: true
				padding: 0
			}
		}

		Row {
			id: row2
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				id: shiftKey
				target: control.target
				targetHandler: null
				text: " ⇧ "
				key: Qt.Key_Shift
				width: control.keyWidth
				checkable: true
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"A":"a"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"S":"s"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"D":"d"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"F":"f"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"G":"g"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"H":"h"
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"J":"j"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"K":"k"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"L":"l"
				modifiers: control.modifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ↵ "
				key: Qt.Key_Enter
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
				padding: 0
			}
		}

		Row {
			id: row3
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ← "
				key: Qt.Key_Left
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}

			VirtualKey {
				id: controlKey
				target: control.target
				targetHandler: null
				text: "Ctl"
				key: Qt.Key_Control
				width: control.keyWidth
				checkable: true
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Z":"z"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"X":"x"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"C":"c"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"V":"v"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"B":"b"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"N":"n"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"M":"m"
				modifiers: d.otherModifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: "  "
				key: Qt.Key_Space
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " → "
				key: Qt.Key_Right
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}
		}
	}
}
