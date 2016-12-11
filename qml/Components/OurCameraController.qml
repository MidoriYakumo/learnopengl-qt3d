import QtQml 2.2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0

import "."

Entity {
	id: root

	/*
		With Qt3D Logic aspect, we can handle various input devices more easily
		the flag bits described with LogicalDevice, neat and tidy
		Refer: qthelp://org.qt-project.qt3d.570/qt3d/qml-qt3d-input-logicaldevice.html
	*/

	property Entity camera
	property real mouseSensitivity: 0.5 // Units.dp
	property real cameraSpeed: 5.

	QtObject {
		id: d

		property real fineScale: fineModifier.active?0.1:1. // with shift key
		property real mouseSensitivity: root.mouseSensitivity*fineScale
		property real cameraSpeed: root.cameraSpeed*fineScale
		property real wAxisValue: 0
		property bool lookActionActived: false
		property bool orbitActionActived: false
		property bool moveActionActived: false
	}

	KeyboardDevice {
		id: keyboardDevice
	}

	MouseDevice {
		id: mouseDevice
		sensitivity: d.mouseSensitivity
	}

	MouseHandler {
		// Wheel LogicDevice would be supported in Qt 5.8
		// See: http://lists.qt-project.org/pipermail/interest/2016-August/024010.html

		sourceDevice: mouseDevice

		onWheel:{
			d.wAxisValue = wheel.angleDelta.y * 1e-3 * d.fineScale
		}
	}

	LogicalDevice {
		// The LogicalDevice, the "managed flag bits"

		enabled: true
		actions: [
			Action {
				// Generally with ActionInput, for button pressing
				// including single key press, key chord and key sequence

				id: lookAction
				ActionInput {
					sourceDevice: mouseDevice
					buttons: [MouseEvent.LeftButton]
				}
			},
			Action {
				id: orbitAction
				ActionInput {
					sourceDevice: mouseDevice
					buttons: [MouseEvent.RightButton]
				}
			},
			Action {
				id: moveAction
				ActionInput {
					sourceDevice: mouseDevice
					buttons: [MouseEvent.MiddleButton]
				}
			},
			Action {
				id: leftMove
				ActionInput {
					sourceDevice: keyboardDevice
					buttons: [Qt.Key_Left, Qt.Key_A]
				}
			},
			Action {
				id: rightMove
				ActionInput {
					sourceDevice: keyboardDevice
					buttons: [Qt.Key_Right, Qt.Key_D]
				}
			},
			Action {
				id: upMove
				ActionInput {
					sourceDevice: keyboardDevice
					buttons: [Qt.Key_Up, Qt.Key_W]
				}
			},
			Action {
				id: downMove
				ActionInput {
					sourceDevice: keyboardDevice
					buttons: [Qt.Key_Down, Qt.Key_S]
				}
			},
			Action {
				id: fineModifier
				ActionInput {
					sourceDevice: keyboardDevice
					buttons: [Qt.Key_Shift]
				}
			}
		]
		axes: [
			Axis {
				// Generally with AxisInput, for analog device value changing
				// usually for mouses and joysticks

				id: xAxis
				AnalogAxisInput {
					sourceDevice: mouseDevice
					axis: MouseDevice.X
				}
			},
			Axis {
				id: yAxis
				AnalogAxisInput {
					sourceDevice: mouseDevice
					axis: MouseDevice.Y
				}
			},
			Axis {
				id: wAxis
//				AnalogAxisInput {
//					sourceDevice: mouseDevice
//					axis: MouseDevice.Wheel
//				}
			}
		]
	}

	FrameSwap {
		onTriggered: {
			if (upMove.active)
				root.camera.position = root.camera.position.plus(
						root.camera.frontVector.times(d.cameraSpeed * dt));
			if (downMove.active)
				root.camera.position = root.camera.position.minus(
						root.camera.frontVector.times(d.cameraSpeed * dt));
			if (rightMove.active)
				root.camera.position = root.camera.position.plus(
						root.camera.rightVector.times(d.cameraSpeed * dt));
			if (leftMove.active)
				root.camera.position = root.camera.position.minus(
						root.camera.rightVector.times(d.cameraSpeed * dt));

			var yaw, pitch
			// ensure relative drags, not click starts
			if (d.lookActionActived && lookAction.active) {
				yaw = root.camera.yaw + xAxis.value;
				pitch = root.camera.pitch - yAxis.value;
				pitch = (pitch>89.)?89.:(pitch<-89.)?-89.:pitch;
				root.camera.yaw = yaw;
				root.camera.pitch = pitch;
			}
			d.lookActionActived = lookAction.active;

			if (d.orbitActionActived && orbitAction.active) {
			}
			d.orbitActionActived = orbitAction.active;

			if (d.moveActionActived && moveAction.active) {
				root.camera.position = root.camera.position.plus(
						root.camera.upVector.times(-yAxis.value)).plus(
						root.camera.rightVector.times(-xAxis.value));
			}
			d.moveActionActived = moveAction.active;

			if (d.wAxisValue != 0) {
				if (d.wAxisValue>0)
					root.camera.fieldOfView = Utils.mix(root.camera.fieldOfView, 1., d.wAxisValue);
				else
					root.camera.fieldOfView = Utils.mix(root.camera.fieldOfView, 180., -d.wAxisValue);
				d.wAxisValue = 0;
			}
		}
	}
}
