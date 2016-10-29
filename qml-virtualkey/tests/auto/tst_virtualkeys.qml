import QtQuick 2.7
import QtTest 1.1

import VirtualKey 1.0


Rectangle {
	id: root

	color: "white"
	height: Units.dp * 600
	width:  Units.dp * 600

	Rectangle {
		id: inner

		color: "black"
		height: Units.dp * 300
		width:  Units.dp * 300
	}

	VirtualKeys {
		id: vkeys
		active: true

		centerItem: VirtualKey { }
	}

	TestCase {
		name: "VirtualKeys"
		when: windowShown

		function test_active() {
			vkeys.active = false
			wait(500)
			verify(!vkeys.visible)
			vkeys.active = true
			wait(500)
			verify(vkeys.visible)
		}

		function test_overlayTarget() {
			vkeys.active = true
			vkeys.overlay = true
			vkeys.overlayTarget = root
			compare(vkeys.height, root.height)
			vkeys.overlayTarget = inner
			compare(vkeys.height, inner.height)
		}

		function test_overlay() {
			vkeys.overlayTarget = root
			vkeys.active = true
			vkeys.overlay = true
			verify(root.anchors.bottomMargin === 0)
			vkeys.overlay = false
			wait(20)
			verify(root.anchors.bottomMargin > 0)
		}

		function test_height() {
			vkeys.overlayTarget = root
			vkeys.active = true
			vkeys.overlay = false
			vkeys.enablePad = false
			vkeys.enableGameButtons = false
			var heightNone = root.anchors.bottomMargin
			vkeys.enablePad = true
			vkeys.enableGameButtons = true
			verify(root.anchors.bottomMargin !== heightNone)
		}
	}
}

