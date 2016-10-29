import QtQuick 2.7
import QtQuick.Window 2.0

Window {
	id: window
	objectName: "root"
	height: 600
	width: 600

	Item {
		id: view
		objectName: "view"
		height: parent.height
		width: parent.width / 2

		property int rectSize: 14 * Screen.logicalPixelDensity

		Grid {
			anchors.centerIn: parent
			columns: parent.width / view.rectSize
			rows: parent.height / view.rectSize

			Repeater {
				model: parent.columns * parent.rows
				delegate: Rectangle {
					id: colorRect
					width: view.rectSize
					height: view.rectSize
					color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
					antialiasing: true

					Behavior on color {
						ColorAnimation {
							duration: 1000
						}
					}

					Timer {
						interval: 3000 * Math.random()
						repeat: true
						running: true
						triggeredOnStart: true
						onTriggered: parent.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
					}

					MouseArea {
						objectName: "Rect%1".arg(index)
						anchors.fill: parent
						onClicked: {
							console.log(objectName)
							if (!animation.running) {
								colorRect.z = 2
								animation.start()
							}
						}
					}

					RotationAnimation on rotation {
						id: animation
						from: 0
						to: (Math.random() > 0.5) ? 360 : -360
						duration: 1000
						running: false
						loops: 1
						onStopped: colorRect.z = 1
					}
				}
			}
		}
	}

	Rectangle {
		id: control
		objectName: "control"
		height: parent.height
		width: parent.width / 2
		x: parent.width / 2

		MultiPointTouchArea {
			id: cMouse
			anchors.fill: parent
			objectName: "cMouse"
			onPressed: {
				console.log(objectName)
				timer.queue = []
				for (var p in touchPoints) {
					var r = ripple.createObject(control)
					r.cx = touchPoints[p].x
					r.cy = touchPoints[p].y

					timer.queue.push({
						 x:touchPoints[p].x,
						 y:touchPoints[p].y
					})
				}
				timer.defer = function() {
					for (var p in timer.queue) {
						var tp = timer.queue[p]
						console.log(p, tp.x, tp.y)
						t.mouseClick(view, tp.x, tp.y)
					}
					cMouse.enabled = true
				}
				enabled = false
				timer.start()
			}
		}
	}

	TestCase {
		id: t
	}

	Timer {
		id: timer

		interval: 0

		property var queue: []
		property var defer: function(){}

		onTriggered: {
			defer()
		}
	}

	Component {
		id: ripple

		Rectangle {
			property int cx
			property int cy

			width: 1
			height: width
			radius: width
			x: cx-width/2
			y: cy-height/2
			opacity: 1-(width/view.rectSize)
			color: "skyblue"

			Behavior on width {
				NumberAnimation {
					duration: 500
				}
			}

			onOpacityChanged: {
				if (opacity <= 0)
					destroy()
			}

			Component.onCompleted: {
				width = view.rectSize + 1
			}
		}
	}

}
