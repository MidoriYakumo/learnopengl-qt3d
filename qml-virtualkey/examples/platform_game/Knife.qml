import QtQuick 2.7

Canvas {
	width: 40
	height: width

	rotation: dirRight?0:180

	property bool dirRight: true
	property color color: "white"

	property real speed: 1

	onXChanged: {
		if (x+width<scene.x || x>scene.width)
			destroy()
	}

	onPaint: {
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.lineWidth = height/9
		ctx.moveTo(width/9, height/2)
		ctx.lineTo(width*2/9, height/2)
		ctx.moveTo(width*3/9, height/2)
		ctx.lineTo(width*4/9, height/2)
		ctx.moveTo(width*5/9, height/2)
		ctx.lineTo(width*8/9, height/2)
		ctx.strokeStyle=color
		ctx.stroke()
		ctx.closePath()

		ctx.restore()
	}

	Timer {
		id: timer
		interval: 16
		repeat: true
		running: true

		onTriggered: {
			parent.x += (parent.dirRight?1:-1) * parent.speed
		}
	}
}
