import QtQuick 2.7
import QtTest 1.1

import VirtualKey 1.0


Item {
	id: root

	height: Units.dp * 600
	width:  Units.dp * 600

	Rectangle {
		id: dude

		color: "#41cd52"
		height: Units.gu
		width:  Units.gu
		radius: Units.gu

		focus: true
		Keys.onPressed: {
			if (event.key === Qt.Key_Up) y -=    Units.gu
			if (event.key === Qt.Key_Down) y +=  Units.gu
			if (event.key === Qt.Key_Left) x -=  Units.gu
			if (event.key === Qt.Key_Right) x += Units.gu
		}
	}

	VirtualPad {
		id: pad

		height:  Units.gu * 3
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.margins: Units.dp * 8

		target: dude
	}

	TestCase {
		name: "VirtualPad"
		when: windowShown

		function test_deflectable() {
			pad.deflectable = false
			var x = dude.x, y = dude.y
			mouseClick(pad, pad.height*3/4, pad.height*3/4)
			compare(Math.abs(dude.x-x) + Math.abs(dude.y-y),
					Units.gu)

			pad.deflectable = true
			x = dude.x
			y = dude.y
			mouseClick(pad, pad.height*3/4, pad.height*3/4)
			compare(Math.abs(dude.x-x) + Math.abs(dude.y-y),
					Units.gu * 2)
		}

		function test_direction() {
			pad.deflectable = true
			mousePress(pad)
			compare(pad.direction, 0)
			var result=[1, 3, 2, 6, 4, 12, 8, 9]
			for (var i=0;i<8;i++) {
				mousePress(pad,
						pad.height/2 * (1.+Math.cos(i*Math.PI/4)),
						pad.height/2 * (1.-Math.sin(i*Math.PI/4))
				)
				compare(pad.direction, result[i])
			}
		}
	}
}

