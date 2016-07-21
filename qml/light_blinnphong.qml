import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings1 {
			id: settings
		}

		KeyboardDevice {
			id: keyboardDevice
		}

		property bool blinn: false

		KeyboardHandler {
			focus: true
			onTabPressed: {
				root.blinn = !root.blinn
				console.log(root.blinn)
			}
			onSpacePressed: {
				anime.paused = !anime.paused
			}

			sourceDevice: keyboardDevice
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

		NodeInstantiator {
			model: root.cubePositions
			delegate: Entity {
				components: [
					CuboidMesh { },
					Transform {
						translation: root.cubePositions[index]
						rotation: dummyTransform.fromAxisAndAngle(
									Qt.vector3d(1, .3, .5), 20. * index)
					},
					BlinnDiffuseSpecularMapMaterial {
						id: material

						blinn: root.blinn
						shininess: 5.
						ambient: Qt.rgba(.2, .2, .2, 1.)
						diffuse: Resources.texture("container2.png")
						specular: Resources.texture("container2_specular.png")
					}
				]
			}
		}


		Transform {
			id: dummyTransform
		}

		Entity {
			components: [
				PlaneMesh {
				},
				Transform {
					scale: 30.
					translation: Qt.vector3d(0, -2, 0)
				},
				BlinnDiffuseSpecularMapMaterial {
					blinn: root.blinn
					shininess: .5
					ambient: Qt.rgba(.2, .2, .2, 1.)
					diffuse: Resources.texture("container2.png")
					specular: Resources.texture("container2.png")
				}
			]
		}

		Entity {
			id: lamp
			components: [lampTransform, light]

			Transform {
				id: lampTransform
				translation: Qt.vector3d(1.2, 1.0, 2.0)
				scale: .2
			}

			SpotLight { // light.inc.frag + cpp to be modified for soft spot light
				id: light
				color: "white"
				localDirection: Qt.vector3d(-1.2, -1.0, -2.0)
				cutOffAngle: Math.sin(timeValue) * 30. + 30.
				constantAttenuation: 1.
				linearAttenuation: .09
				quadraticAttenuation: .032

				property real timeValue: 0.

				QQ2.NumberAnimation {
					id: anime
					target: light
					properties: "timeValue"
					from: 0.
					to: Math.PI * 2
					duration: 10000
					loops: QQ2.Animation.Infinite
					running: true
				}
			}

		}
	}
}
