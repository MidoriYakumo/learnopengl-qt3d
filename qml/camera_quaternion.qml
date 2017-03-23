import Qt3D.Core 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		enableGameButtons: false
		color: "transparent"
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
			sensitivity: 0.5
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
				var sensitivity = mouseDevice.sensitivity * 0.1;
				if (mouse.modifiers & Qt.ShiftModifier)
					sensitivity *= .1;

				var v1 = camera.frontVector;
				var v2 = camera.frontVector.plus(
					camera.upVector.times((posY - mouse.y)*sensitivity)).plus(
					camera.rightVector.times((mouse.x - posX)*sensitivity));
				var rot = new Geo.Quaternion().rotationTo(v1, v2);
				camera.quaternion = camera.quaternion.times(rot);

				posX = mouse.x;
				posY = mouse.y;
			}

			onWheel: {
				var d = wheel.angleDelta.y * 1e-3;
				if (d>0)
					camera.fieldOfView = Utils.mix(camera.fieldOfView, 1., d);
				else
					camera.fieldOfView = Utils.mix(camera.fieldOfView, 45., -d);
			}
		}

		FrameSwap {
			property real cameraSpeed: 5.
			onTriggered: {
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
			}
		}

		Entity {
			id: camera

			property real fieldOfView: 45

			property var quaternion: new Geo.Quaternion(1, 0, 0, 0)
			property vector3d position: "0,0,3"
			property vector3d viewCenter: position.plus(frontVector)
			property vector3d upVector: "0,1,0"
			property vector3d frontVector: quaternion.rotated(Qt.vector3d(0, 0, -1)).toQtType()
			property vector3d rightVector: frontVector.crossProduct(upVector)

			property matrix4x4 viewMatrix: {
				var m = Qt.matrix4x4();
//				m.m14 = -position.x;
//				m.m24 = -position.y;
//				m.m34 = -position.z;
//				m = quaternion.toMatrix().toQtType().times(m);
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
					rotation: fromAxisAndAngle(Qt.vector3d(.5, 1, 0), 20 * index)
				}
				viewMatrix: camera.viewMatrix
				projectionMatrix: camera.projectionMatrix
			}
		}


	}
}
