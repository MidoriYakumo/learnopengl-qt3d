import QtQuick 2.7

Canvas {
	width: 40
	height: width

	property color color: "white"
	property real speedX: 1
	property real speedY: -1
	property real accY: -1

	onYChanged: {
		if (y>ground.y)
			destroy()
	}

	opacity: (ground.y-y)*2/height-1

	onPaint: {
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.moveTo(width/2, 0)
		ctx.lineTo(width*0.933, height*.75)
		ctx.lineTo(width*0.067, height*.75)
		ctx.fillStyle=color
		ctx.fill()
		ctx.closePath()

		ctx.restore()
	}

	Timer {
		id: timer
		interval: 16
		repeat: true
		running: true

		onTriggered: {
			parent.x += parent.speedX
			parent.y += parent.speedY
			parent.speedY += parent.accY
			parent.rotation += parent.speedX
		}
	}
}
