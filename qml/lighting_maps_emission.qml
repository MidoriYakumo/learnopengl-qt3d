import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings0 {
			id: settings
		}

		Entity {
			id: chest
			components: [cube, objMaterial]

			DiffuseSpecularEmissionMapMaterial {
				id: objMaterial

				ambient: Qt.rgba(.2, .2, .2, 1.)
				diffuseName: "container2.png"
				specularName: "container2_specular.png"
				emissionName: "matrix.jpg"
			}
		}


		Entity {
			id: lamp
			components: [cube, lampTransform, lampMaterial, light]

			Transform {
				id: lampTransform
				translation: Qt.vector3d(1.2, 1.0, 2.0)
				scale: .2
			}

			PointLight {
				id: light
				color: "white"
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
