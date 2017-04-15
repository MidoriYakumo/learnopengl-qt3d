import Qt3D.Core 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		gameButtonsEnabled: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space},
			]
		}
	}

	Entity {
		id: root

		RenderSettings1 {}

		InputSettings {}

		KeyboardDevice {
			id: keyboardDevice
		}

		property var keys: {
			"up":false, "down":false, "left":false, "right": false
		}

		KeyboardHandler {
			id: keyboardHandler
			sourceDevice: keyboardDevice
			focus: true

			onPressed: {
				switch (event.key) {
				case Qt.key_W:
				case 'W'.charCodeAt(0):
				case Qt.Key_Up:
					root.keys.up = true;
					break;
				case Qt.key_S:
				case 'S'.charCodeAt(0):
				case Qt.Key_Down:
					root.keys.down = true;
					break;
				case Qt.key_A:
				case 'A'.charCodeAt(0):
				case Qt.Key_Left:
					root.keys.left = true;
					break;
				case Qt.key_D:
				case 'D'.charCodeAt(0):
				case Qt.Key_Right:
					root.keys.right = true;
					break;
				case Qt.Key_Space: // Note: Bonus: jump!
					camera.ySpeed /*+*/= 3.;
					break;
				}
			}

			onReleased: {
				switch (event.key) {
				case Qt.key_W:
				case 'W'.charCodeAt(0):
				case Qt.Key_Up:
					root.keys.up = false;
					break;
				case Qt.key_S:
				case 'S'.charCodeAt(0):
				case Qt.Key_Down:
					root.keys.down = false;
					break;
				case Qt.key_A:
				case 'A'.charCodeAt(0):
				case Qt.Key_Left:
					root.keys.left = false;
					break;
				case Qt.key_D:
				case 'D'.charCodeAt(0):
				case Qt.Key_Right:
					root.keys.right = false;
					break;
				}
			}
		}

		MouseDevice {
			id: mouseDevice
			sensitivity: .5 / Units.dp
		}

		MouseHandler {
			id: mouseHandler
			sourceDevice: mouseDevice

			property int posX
			property int posY

			onPressed: {
				posX = mouse.x;
				posY = mouse.y;
			}

			onPositionChanged: {
				var sensitivity = mouseDevice.sensitivity;
				if (mouse.modifiers & Qt.ShiftModifier)
					sensitivity *= .1;
				var yaw = camera.yaw + (mouse.x - posX) * sensitivity;
				var pitch = camera.pitch + (mouse.y - posY) * sensitivity;

				pitch = (pitch>89.)?89.:(pitch<-89.)?-89.:pitch;

				camera.yaw = yaw;
				camera.pitch = pitch;

				posX = mouse.x;
				posY = mouse.y;
			}

			onWheel: {
				var d = wheel.angleDelta.y * 1e-3;
				if (d>0)
					camera.fieldOfView = Geo.mix(camera.fieldOfView, 1., d);
				else
					camera.fieldOfView = Geo.mix(camera.fieldOfView, 45., -d);
			}
		}

		FrameSwap {
			property real cameraSpeed: 5.

			onTriggered: {
				var y = camera.position.y;
				if (root.keys.up)
					camera.position = camera.position.plus(
						camera.frontVector.times(cameraSpeed * dt));
				if (root.keys.down)
					camera.position = camera.position.minus(
						camera.frontVector.times(cameraSpeed * dt));
				if (root.keys.right)
					camera.position = camera.position.plus(
						camera.rightVector.times(cameraSpeed * dt));
				if (root.keys.left)
					camera.position = camera.position.minus(
						camera.rightVector.times(cameraSpeed * dt));

				camera.position.y = y + camera.ySpeed * dt;
				if (camera.position.y>0.)
					camera.ySpeed -= dt * 9.8;
				else {
					if (camera.position.y<0.)
						camera.position.y = 0.;
					camera.ySpeed = 0.;
				}

			}
		}

		Entity {
			id: camera

			property real yaw: 0
			property real pitch: 0
			property real fieldOfView: 45
			property real ySpeed: 0.

			property vector3d position: "0,0,3"
			property vector3d viewCenter: position.plus(frontVector)
			property vector3d upVector: "0,1,0"
			property vector3d frontVector: Qt.vector3d(
				Math.cos(pitch * Math.PI / 180.) * Math.sin(yaw * Math.PI / 180.),
				-Math.sin(pitch * Math.PI / 180.),
				-Math.cos(pitch * Math.PI / 180.) * Math.cos(yaw * Math.PI / 180.)
			)
			property vector3d rightVector: frontVector.crossProduct(upVector).normalized()

			property matrix4x4 viewMatrix: {
				var m = Qt.matrix4x4();
				m.lookAt(position, viewCenter, upVector);
				return m;
			}
			property matrix4x4 projectionMatrix: {
				var aspect = scene.width / scene.height;
				var zNear = .1;
				var zFar = 100.;
				var h = Math.tan(fieldOfView * Math.PI / 360) * zNear;
				var w = h * aspect;

				var m = Qt.matrix4x4();
				m.m11 = zNear / w;
				m.m22 = zNear / h;
				m.m33 = - (zNear + zFar) / (zFar - zNear);
				m.m34 = -2 * zNear * zFar / (zFar - zNear);
				m.m43 = -1;
				m.m44 = 0;
				return m;
			}
		}

		property var cubePositions: [
			Qt.vector3d( 0.0,  0.0,  0.0),
			Qt.vector3d( 2.0,  5.0, -15.0),
			Qt.vector3d(-1.5, -2.2, -2.5),
			Qt.vector3d(-3.8, -2.0, -12.3),
			Qt.vector3d( 2.4, -0.4, -3.5),
			Qt.vector3d(-1.7,  3.0, -7.5),
			Qt.vector3d( 1.3, -2.0, -2.5),
			Qt.vector3d( 1.5,  2.0, -2.5),
			Qt.vector3d( 1.5,  0.2, -1.5),
			Qt.vector3d(-1.3,  1.0, -1.5),
		]

		NodeInstantiator {
			model: root.cubePositions
			delegate: TextureCube0 {
				transform: Transform {
					translation: modelData
					rotation: fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), 20 * index)
				}
				viewMatrix: camera.viewMatrix
				projectionMatrix: camera.projectionMatrix
			}
		}


	}
}

