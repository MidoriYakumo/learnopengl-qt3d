import QtQuick 2.7
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0

import "."

Canvas {
	id: root
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property int direction
	property /*KeyEvent*/var dummy
	property int arrowSize: height/10
	property color buttonColor: /*"#80e0e0e0"*/"#e0e0e0"
	property color accentColor: "#e91f67"
	property color primaryTextColor: "#1d252c"
	opacity: .7

	onDirectionChanged: requestPaint()

	onPaint: {
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.arc(height/2, width/2, height/2, 0, 2 * Math.PI)
		ctx.fillStyle = /*Material.*/buttonColor
		ctx.fill()
		ctx.closePath()


		ctx.beginPath()
		ctx.arc(height/2, width/2, arrowSize*2, 0, 2 * Math.PI)
		ctx.strokeStyle = primaryTextColor
		ctx.stroke()
		ctx.closePath()

		ctx.fillStyle = direction===3?/*Material.*/accentColor:/*Material.*/primaryTextColor

		ctx.beginPath()
		ctx.moveTo(arrowSize, height/2)
		ctx.lineTo(arrowSize*2, height/2-arrowSize)
		ctx.lineTo(arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction===1?/*Material.*/accentColor:/*Material.*/primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width-arrowSize, height/2)
		ctx.lineTo(width-arrowSize*2, height/2-arrowSize)
		ctx.lineTo(width-arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction===2?/*Material.*/accentColor:/*Material.*/primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width/2, arrowSize)
		ctx.lineTo(width/2-arrowSize, arrowSize*2)
		ctx.lineTo(width/2+arrowSize, arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction===4?/*Material.*/accentColor:/*Material.*/primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width/2, height-arrowSize)
		ctx.lineTo(width/2-arrowSize, height-arrowSize*2)
		ctx.lineTo(width/2+arrowSize, height-arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.restore()
	}

	MouseArea {
		id: mouse
		anchors.fill: parent

		property int posX
		property int posY

		function detectRegion(x, y) {
			if (x === undefined) {
				x = posX
				y = posY
			}

			x -= width/2
			y -= height/2

			var dis = Math.sqrt(x*x+y*y)

			if (dis<arrowSize*2 || dis>height/2) {
				return 0
			}

			if (Math.abs(x)>Math.abs(y)) {
				if (x>0)
					return 1 // right
				else
					return 3 // left
			} else if (y>0)
				return 4 // down
			else
				return 2 // up
		}

		onPressed: {
			posX = mouseX
			posY = mouseY
			if (detectRegion()) {
				mouse.accepted = true
				trigger.start()
			} else {
				mouse.accepted = false
			}

		}

		onPositionChanged: {
			posX = mouseX
			posY = mouseY
		}

		onReleased: {
			trigger.stop()
			root.direction = 0
		}

		onEntered: {
			posX = mouseX
			posY = mouseY
			trigger.start()
		}

		onExited: {
			trigger.stop()
			root.direction = 0
		}

		Timer {
			id: trigger
			interval: 1000/30
			repeat: true

			onTriggered: {
				root.direction = mouse.detectRegion()
				if (root.direction) {
					target.focus = false
					target.focus = true
				}
				if (root.targetHandler) {
					switch (root.direction) {
					case 1:
						root.targetHandler.rightPressed(dummy)
						break
					case 2:
						root.targetHandler.upPressed(dummy)
						break
					case 3:
						root.targetHandler.leftPressed(dummy)
						break
					case 4:
						root.targetHandler.downPressed(dummy)
						break
					default:
						break
					}
				} else {
					switch (root.direction) {
					case 1:
						KeyEventSource.keyPress(Qt.Key_Right, Qt.NoModifier, -1)
						break
					case 2:
						KeyEventSource.keyPress(Qt.Key_Up, Qt.NoModifier, -1)
						break
					case 3:
						KeyEventSource.keyPress(Qt.Key_Left, Qt.NoModifier, -1)
						break
					case 4:
						KeyEventSource.keyPress(Qt.Key_Down, Qt.NoModifier, -1)
						break
					default:
						break
					}
				}
			}
		}
	}
}
