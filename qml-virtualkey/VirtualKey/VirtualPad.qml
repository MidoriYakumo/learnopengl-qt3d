import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

Canvas {
	id: control
	height: Units.gu * 3
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property bool deflectable: true
	property int repeatInterval: 40
	property int arrowSize: height/9
	property int innerRadius: (height-arrowSize*6)/2

	readonly property alias pressed		: d.pressed
	readonly property alias direction	: d.direction

	QtObject {
		id: d

		property bool pressed
		property int direction
		property int directionToRelease: 0
	}

	Material.elevation: pressed ? 8 : 2

	layer.enabled: true //control.Material.buttonColor.a > 0
////	layer.effect: ElevationEffect { // Not work ???
////		elevation: control.Material.elevation
////	}
	layer.effect: DropShadow {
		color: Qt.rgba(0,0,0,.32)
		radius: control.Material.elevation * 1.5
		spread: control.Material.elevation * 0.02
		horizontalOffset: pressed?
			-(mouse.width/2 - mouse.mouseX) * radius / mouse.width / 2:
			0
		verticalOffset: pressed?
			-(mouse.height/2 - mouse.mouseY) * radius / mouse.height / 2:
			0
	}

	state: "freeze"

	states: [
		State {
			name: "freeze"
			PropertyChanges {
				target: repeatTrigger
				running: false
			}
		},
		State {
			name: "press"
			PropertyChanges {
				target: repeatTrigger
				running: true
				onTriggered: mouse.key_press(direction)
			}
		},
		State {
			name: "release"
			PropertyChanges {
				target: repeatTrigger
				running: true
				onTriggered: {
					mouse.key_release(d.directionToRelease & ~direction)
					d.directionToRelease = direction
					state = pressed?"press":"freeze"
				}
			}
		}
	]


	onPressedChanged: requestPaint()
	onDirectionChanged: {
		requestPaint()
		if (d.directionToRelease !== direction)
			state = "release"
	}

	onPaint: {
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.arc(width/2, height/2, height/2, 0, 2 * Math.PI)
		ctx.fillStyle = pressed?control.Material.buttonPressColor:control.Material.buttonColor
		ctx.fill()
		ctx.closePath()


		ctx.beginPath()
		ctx.arc(width/2, height/2, innerRadius, 0, 2 * Math.PI)
		ctx.strokeStyle = control.Material.foreground
		ctx.stroke()
		ctx.closePath()

		ctx.fillStyle = direction&4?
					control.Material.primaryHighlightedTextColor:
					control.Material.foreground

		ctx.beginPath()
		ctx.moveTo(arrowSize, height/2)
		ctx.lineTo(arrowSize*2, height/2-arrowSize)
		ctx.lineTo(arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&1?
					control.Material.primaryHighlightedTextColor:
					control.Material.foreground

		ctx.beginPath()
		ctx.moveTo(width-arrowSize, height/2)
		ctx.lineTo(width-arrowSize*2, height/2-arrowSize)
		ctx.lineTo(width-arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&2?
					control.Material.primaryHighlightedTextColor:
					control.Material.foreground

		ctx.beginPath()
		ctx.moveTo(width/2, arrowSize)
		ctx.lineTo(width/2-arrowSize, arrowSize*2)
		ctx.lineTo(width/2+arrowSize, arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&8?
					control.Material.primaryHighlightedTextColor:
					control.Material.foreground

		ctx.beginPath()
		ctx.moveTo(width/2, height-arrowSize)
		ctx.lineTo(width/2-arrowSize, height-arrowSize*2)
		ctx.lineTo(width/2+arrowSize, height-arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.restore()
	}

//	MouseArea {
	MultiPointTouchArea {
		id: mouse
		anchors.fill: parent
		maximumTouchPoints: 1

		property real mouseX
		property real mouseY

		function calcDirection(x, y) {
			x -= width/2
			y -= height/2

			var dis2 =x*x+y*y

			if ((dis2<innerRadius*innerRadius) || (dis2*4>height*height)) {
				return 0
			}

			if (deflectable) {
				if (Math.abs(x)>1.732*Math.abs(y))
					if (x>0)
						return 1 // right
					else
						return 4 // left
				else if (Math.abs(x)*1.732<Math.abs(y))
					if (y>0)
						return 8 // down
					else
						return 2 // up
				else
					return ((x>0)?1:4)|((y>0)?8:2)
			} else if (Math.abs(x)>Math.abs(y))
				if (x>0)
					return 1 // right
				else
					return 4 // left
			else if (y>0)
				return 8 // down
			else
				return 2 // up
		}

		function key_press(direction) {
			// console.log("key_press", direction)
			if (direction) {
				target.focus = true
				if (targetHandler) {
					if (direction & 1)
						targetHandler.rightPressed(InputEventSource.dummyKeyEvent)
					if (direction & 2)
						targetHandler.upPressed(InputEventSource.dummyKeyEvent)
					if (direction & 4)
						targetHandler.leftPressed(InputEventSource.dummyKeyEvent)
					if (direction & 8)
						targetHandler.downPressed(InputEventSource.dummyKeyEvent)
				} else {
					if (direction & 1)
						InputEventSource.keyPress(Qt.Key_Right, Qt.NoModifier, -1)
					if (direction & 2)
						InputEventSource.keyPress(Qt.Key_Up, Qt.NoModifier, -1)
					if (direction & 4)
						InputEventSource.keyPress(Qt.Key_Left, Qt.NoModifier, -1)
					if (direction & 8)
						InputEventSource.keyPress(Qt.Key_Down, Qt.NoModifier, -1)
				}
			}
		}

		function key_release(direction) {
			// console.log("key_release", direction)
			if (direction) {
				target.focus = true
				if (targetHandler) {
//					var event = {
//						"key": Qt.Key_unknown,
//						"modifiers": Qt.NoModifier,
//						"text": ""
//					}
//					if (direction & 1){
//						event.key = Qt.Key_Right
//						targetHandler.onReleased(event)
//					}
//					if (direction & 2){
//						event.key = Qt.Key_Up
//						targetHandler.onReleased(event)
//					}
//					if (direction & 4) {
//						event.key = Qt.Key_Left
//						targetHandler.onReleased(event)
//					}
//					if (direction & 8) {
//						event.key = Qt.Key_Down
//						targetHandler.onReleased(event)
//					}
				} else {
					if (direction & 1)
						InputEventSource.keyRelease(Qt.Key_Right, Qt.NoModifier, -1)
					if (direction & 2)
						InputEventSource.keyRelease(Qt.Key_Up, Qt.NoModifier, -1)
					if (direction & 4)
						InputEventSource.keyRelease(Qt.Key_Left, Qt.NoModifier, -1)
					if (direction & 8)
						InputEventSource.keyRelease(Qt.Key_Down, Qt.NoModifier, -1)
				}
			}
		}

		onPressed: {
			var p = touchPoints[0]
			mouseX = p.x
			mouseY = p.y
			d.pressed = ((mouseX-width/2)*(mouseX-width/2)+
				(mouseY-height/2)*(mouseY-height/2))*4<=height*height
			d.directionToRelease = calcDirection(mouseX, mouseY)
			d.direction = d.directionToRelease
			if (direction>0)
				control.state = "press"
		}

//		onPositionChanged: {
		onUpdated: {
			var p = touchPoints[0]
			mouseX = p.x
			mouseY = p.y
			d.pressed = ((mouseX-width/2)*(mouseX-width/2)+
				(mouseY-height/2)*(mouseY-height/2))*4<=height*height
			d.direction = calcDirection(mouseX, mouseY)
		}

		onReleased: {
			d.pressed = false
			if (direction === 0)
				control.state = "freeze"
			else
				d.direction = 0
		}
	}

	Timer {
		id: repeatTrigger
		interval: repeat?repeatInterval:0
		repeat: repeatInterval>0
		triggeredOnStart: true
	}

}
