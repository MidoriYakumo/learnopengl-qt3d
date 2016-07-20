import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings1 {
			id: settings
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
			Qt.vector3d(-1.3,  1.0, -1.5)
		]

		QQ2.Component.onCompleted: {
			var component = Qt.createComponent("Components/Box1.qml")
			for (var i in cubePositions) {
				var box = component.createObject(root)
				box.transform.translation = cubePositions[i]
				box.transform.rotation = dummyTransform.fromAxisAndAngle(
							Qt.vector3d(1, .3, .5), 20. * i)
			}
		}


		Transform {
			id: dummyTransform
		}

		Entity {
			id: lamp
			components: [cube, lampTransform, lampMaterial, light]

			Transform {
				id: lampTransform
				translation: Qt.vector3d(1.2, 1.0, 2.0)
				scale: .2
			}

			PointLight { // 1. ambient is not in light -> no addition, 2. quadratic attenuation model in gl3 shader only
				id: light
				color: "white"
				constantAttenuation: 1.
				linearAttenuation: .09
				quadraticAttenuation: .032
			}

			PhongMaterial {
				id: lampMaterial
				ambient: "white"
			}
		}

		CuboidMesh {
			id: cube
		}
	}
}
