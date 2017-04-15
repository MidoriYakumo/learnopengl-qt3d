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
				case 'W'.charCodeAt(0): // BUG ???
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

		FrameSwap {
			/*
				FrameAction: The event between frames change
				in triggered() method, dt is provided by Qt for delta calculations
			*/

			property real cameraSpeed: .05

			onTriggered: {
				if (root.keys.up)
					camera.position = camera.position.plus(camera.frontVector.times(cameraSpeed));
				if (root.keys.down)
					camera.position = camera.position.minus(camera.frontVector.times(cameraSpeed));
				if (root.keys.right)
					camera.position = camera.position.plus(camera.rightVector.times(cameraSpeed));
				if (root.keys.left)
					camera.position = camera.position.minus(camera.rightVector.times(cameraSpeed));
			}
		}

		Entity {
			id: camera

			property vector3d position: "0,0,3"
			property vector3d viewCenter: position.plus(frontVector)
			property vector3d upVector: "0,1,0"
			property vector3d frontVector: "0,0,-1"
			property vector3d rightVector: frontVector.crossProduct(upVector).normalized()

			property matrix4x4 viewMatrix: {
				var m = Qt.matrix4x4();
				m.lookAt(position, viewCenter, upVector);
				return m;
			}
			property matrix4x4 projectionMatrix: {
				var fov = 45;
				var aspect = scene.width / scene.height;
				var zNear = .1;
				var zFar = 100.;
				var h = Math.tan(fov * Math.PI / 360) * zNear;
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
