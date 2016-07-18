import QtQuick 2.7 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Logic 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

//import "."
import "misc.js" as Misc

Entity {
	id: inputs

	property bool debug: false
	property Camera camera

	InputSettings {
		id: inputSettings
	}
//	property InputSettings inputSettings: TheInputSettings
//	QQ2.Component.onCompleted: {
//		TheInputSettings.parent = inputs
//	}
//	QQ2.Component.onDestruction: {
//		console.log("onDestruction")
//		console.log("parent:%1, eventSource:%2".arg(TheInputSettings.parent).arg(TheInputSettings.eventSource))
//		TheInputSettings.parent = null
//		TheInputSettings.eventSource = null
//	}


	FirstPersonCameraController { camera: inputs.camera }

	MouseDevice { id:mouse1 }

	MouseHandler {
		sourceDevice: mouse1
		onWheel: {
			var d = wheel.angleDelta.y * 1e-3
			if (d>0)
				inputs.camera.fieldOfView = Misc.mix(inputs.camera.fieldOfView, 1., d)
			else
				inputs.camera.fieldOfView = Misc.mix(inputs.camera.fieldOfView, 90., -d)
			if (debug)
				console.log("camera.fieldOfView = %1".arg(inputs.camera.fieldOfView))
		}
	}

	KeyboardDevice { id: keyboard1 }

	KeyboardHandler {
		sourceDevice: keyboard1
		focus: true // Required, by tests

		onPressed: {
			switch (event.key) {
			case Qt.Key_Control: {
				if (debug) {
					console.log("position	= ", inputs.camera.position)
					console.log("viewCenter	= ", inputs.camera.viewCenter)
					console.log("front	= ", frontNormalized)
				}
				break
			}
			case Qt.Key_W: {
				movement.w = Qt.vector3d(0, 0, 1)
				break
			}
			case Qt.Key_S: {
				movement.s = Qt.vector3d(0, 0, -1)
				break
			}
			case Qt.Key_A: {
				movement.a = Qt.vector3d(-1, 0, 0)
				break
			}
			case Qt.Key_D: {
				movement.d = Qt.vector3d(1, 0, 0)
				break
			}
			case Qt.Key_Shift: {
				movement.acc = .2
				break
			}
			}
		}

		onReleased: {
			switch (event.key) {
			case Qt.Key_W: {
				movement.w = movement.zero
				break
			}
			case Qt.Key_S: {
				movement.s = movement.zero
				break
			}
			case Qt.Key_A: {
				movement.a = movement.zero
				break
			}
			case Qt.Key_D: {
				movement.d = movement.zero
				break
			}
			case Qt.Key_Shift: {
				movement.acc = 1.
				break
			}
			}
		}
	}

	FrameAction {
		id: movement

		readonly property real scale: 1e1
		property real acc: 1.
		property vector3d w: zero
		property vector3d s: zero
		property vector3d a: zero
		property vector3d d: zero
		property vector3d velocity: w.plus(s).plus(a).plus(d)
		readonly property vector3d zero: Qt.vector3d(0,0,0)

		onTriggered: {
			if (velocity !== zero) {
				inputs.camera.translate(velocity.times(acc * scale * dt))
				if (debug)
					console.log("camera.viewCenter = %1".arg(inputs.camera.viewCenter))
			}

			frameCounter++
		}
	}

	property int fps: 60
	property int frameCounter: 0

	QQ2.Timer {
		interval: 500
		repeat: true
		running: true

		onTriggered: {
			fps = (fps + frameCounter * 1000 / interval) / 2
			try {
				app.fps = fps
			} catch (e) {

			}

			frameCounter = 0;
		}
	}
}
