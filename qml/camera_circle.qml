import Qt3D.Core 2.0

import "Components"

Scene1 {
	id: scene

	Entity {
		id: root

		RenderSettings1 {}

		FrameSwap {}

		Time {
			id: time
		}

		Entity { // Our Camera type !
			id: camera

			property vector3d position: Qt.vector3d(10.*Math.sin(time.value), 0, 10.*Math.cos(time.value))
			property vector3d viewCenter: "0,0,0"
			property vector3d upVector: "0,1,0"

			property matrix4x4 viewMatrix: {
				var m = Qt.matrix4x4();
				// Use Qt lookAt, reference: qthelp://org.qt-project.qtgui.570/qtgui/qmatrix4x4.html#lookAt
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
			delegate: TextureCube0 { // Moved to Cube type
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
