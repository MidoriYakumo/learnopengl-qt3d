import QtQuick 2.7

import VirtualKey 1.0

Rectangle {
	id: scene
	width: 800
	height: 600
	focus: true
	color: "teal"

	Rectangle {
		id: ground

		anchors.bottom: scene.bottom
		width: scene.width
		height: Math.min(Math.max(scene.height/3, Units.gu * 2), Units.gu * 6)
		color: "coral"
	}

	Rectangle {
		id: player

		property real speedX: 0
		property real speedY: 0
		property real speedR: speedX / Units.dp
		property real bottomY: ground.y
		property bool onTheGround: bottomY >= ground.y - .5
		property bool secondJump: false
		property var  keys: {"up": false}

		y: bottomY - height * (0.5 + 0.7071 *
							   Math.max(Math.abs(Math.cos((45-rotation) * Math.PI / 180)),
							   Math.abs(Math.cos((rotation-135) * Math.PI / 180))
							  ))

		antialiasing: true
		height: Units.gu
		width: height
		color: "white"

		Behavior on speedX {
			NumberAnimation {
				duration: 200
			}
		}

		NumberAnimation {
			id: rotate
			target: player
			property: "rotation"
			running: false
		}

		function getNearest(deg) {
			for (var i=0;i<=4;i++) {
				if (Math.abs(90 * i + deg - rotation)<=45)
					return 90 * i + deg
			}
			return deg
		}
	}

	Timer {
		id: fs
		interval: 16
		repeat: true
		running: true

		onTriggered: {
			player.x += player.speedX
			if (player.x >= scene.width - player.width * 1.2) {
				player.x = scene.width - player.width * 1.2
				player.speedX = 0
			}
			if (player.x <= player.width * .3) {
				player.x = player.width * .3
				player.speedX = 0
			}

			player.bottomY += player.speedY
			if (player.speedY>0 && player.onTheGround) {
				player.bottomY = ground.y
				player.speedY = 0
				player.secondJump = false
			} else {
				player.speedY += Units.dp / 1e2 * interval
			}

			if (!rotate.running)
				player.rotation = (360 + player.rotation + player.speedR) % 360

			chain.dirRight = player.speedR>0?true:player.speedR<0?false:chain.dirRight
		}
	}

	Keys.onPressed: {
		switch (event.key) {
		case Qt.Key_Left:
			if (player.onTheGround) {
				player.speedX = -Units.dp * 20
				rotate.stop()
			}
			player.keys["left"] = true
			break
		case Qt.Key_Right:
			if (player.onTheGround) {
				player.speedX = Units.dp * 20
				rotate.stop()
			}
			player.keys["right"] = true
			break
		case Qt.Key_Up:
			player.keys["up"] = true
			break
		case Qt.Key_Down:
			player.keys["down"] = true
			break
		case Qt.Key_Z:
			if (!player.secondJump) {
				if (!player.onTheGround)
					player.secondJump = true
				player.speedY = -Units.dp * 9
			}
			player.keys["z"] = true
			break
		case Qt.Key_X:
			var knife
			if (player.keys["right"]) {
				knife = knifeComp.createObject(scene)
				knife.x = player.x
				knife.y = player.y
				knife.speed = Units.dp * 30
			} else if (player.keys["left"]) {
				knife = knifeComp.createObject(scene)
				knife.dirRight = false
				knife.x = player.x
				knife.y = player.y
				knife.speed = Units.dp * 30
			} else if (player.keys["up"]) {
				var axe = axeComp.createObject(scene)
				axe.x = player.x
				axe.y = player.y
				axe.speedX = Units.dp * 2
					* (1.+Math.random())
					* (Math.random()>.5?1:-1)
				axe.speedY = -Units.dp * 11
				axe.accY = Units.dp / 1e2 * fs.interval
			} else {
				chain.ey = 0
				attack.running = true
			}

			break
		}

		if (!player.onTheGround && player.keys["down"]) {
			player.speedY = Units.dp * 19
			rotate.duration = 100
			rotate.to = player.getNearest(45)
			rotate.restart()
			if (player.keys["left"])
				player.speedX = -Units.dp * 20
			else if (player.keys["right"])
				player.speedX = Units.dp * 20
		}
	}

	Keys.onReleased: {
		switch (event.key) {
		case Qt.Key_Left:
			player.speedX = 0
			rotate.duration = 500
			rotate.to = player.getNearest(0)
			rotate.restart()
			player.keys["left"] = false
			break
		case Qt.Key_Right:
			player.speedX = 0
			rotate.duration = 500
			rotate.to = player.getNearest(0)
			rotate.restart()
			player.keys["right"] = false
			break
		case Qt.Key_Up:
			player.keys["up"] = false
			break
		case Qt.Key_Down:
			player.keys["down"] = false
			break
		case Qt.Key_Z:
			player.keys["z"] = false
			break
		}
	}

	Component {
		id: knifeComp
		Knife {
			width: player.width
		}
	}

	Component {
		id: axeComp
		Axe {
			width: player.width
		}
	}

	Chain {
		id: chain
		man: player

		property bool dirRight: true

		SequentialAnimation {
			id: attack
			NumberAnimation {
				target: chain
				property: "ex"
				from: 0
				to: player.width * 2 * (chain.dirRight?1:-1)
				duration: 200
				easing.type: Easing.InOutQuad
			}
			ParallelAnimation {
				NumberAnimation {
					target: chain
					property: "ex"
					from: player.width * 2 * (chain.dirRight?1:-1)
					to: 0
					duration: 200
					easing.type: Easing.InOutQuad
				}
				NumberAnimation {
					target: chain
					property: "ey"
					from: 0
					to: player.width / 3
					duration: 200
					easing.type: Easing.InOutQuad
				}
			}
		}
	}
}
