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

		Entity{
			id: bot1
			components: [bot1Model, bot1Transform]

			Transform {
				id: bot1Transform
				translation: Qt.vector3d(-4, -8, -20)
				rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .2), 45)
			}
		}

		Entity{
			id: bot2
			components: [mesh, bot2Transform, mat]

			CuboidMesh {
				id: mesh
			}

			PhongMaterial{
				id: mat
				ambient: "#aa2288"
				diffuse: "#e3e3e3"
			}

			Transform {
				id: bot2Transform
				translation: Qt.vector3d(4, -8, -20)
				rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .2), -45)
			}
		}

		SceneLoader {
			id: bot1Model
			source: Resources.model("nanosuit.obj")

			onStatusChanged:
				if (status == 2) {
//					var bot2Model = Qt.createQmlObject('
//						import Qt3D.Render 2.0;
//						import "Components";
//						SceneLoader {
//							source: Resources.model("nanosuit.obj")
//						}', root)
					console.log(status)
					bot2.components = [bot2Model, bot2Transform]
			}
		}

		SceneLoader {
			id: bot2Model
			source: Resources.model("nanosuit.obj")
		}

		Entity {
			id: sun
			components: [transform, light]

			Transform {
				id: transform
				translation: Qt.vector3d(0, 1, 1.)
			}

			DirectionalLight {
				id: light
				color: "white"
				worldDirection: Qt.vector3d(0, -1, -1.)
			}
		}

	}
}
