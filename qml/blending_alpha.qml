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
		}

		Entity {
			id: ground
			components: [plane, groundTransform, groundMaterial]

			Transform {
				id: groundTransform
				scale: 100.
				rotation: fromAxisAndAngle(Qt.vector3d(1., 0., 0.), 10)
			}

			PhongMaterial {
				id: groundMaterial
				diffuse: "gray"
			}
		}

		Entity {
			id: grass0
			components: [plane, grassTransform, grassMaterial]

			Transform {
				id: grassTransform
				translation: Qt.vector3d(0, .5, 0)
				rotation: fromAxisAndAngle(Qt.vector3d(1., 0., 0.), 80)
			}

			DiffuseDiscardMapMaterial {
				id: grassMaterial
				diffuse: Resources.texture("grass.png")
				ambient:  Qt.rgba( 0.5, 0.5, 0.5, 1.0 )
				specular: Qt.rgba( 0.01, 0.01, 0.01, 1.0 )
			}
		}

		Entity {
			id: window0
			components: [plane, windowTransform, windowMaterial]

			Transform {
				id: windowTransform
				translation: Qt.vector3d(0., .5, 1.)
				rotation: fromAxisAndAngle(Qt.vector3d(1., 0., 0.), 90)
			}

			DiffuseAlphaMapMaterial {
				id: windowMaterial
				diffuse: Resources.texture("blending_transparent_window.png")
				ambient:  Qt.rgba( 0.5, 0.5, 0.5, 1.0 )
				specular: Qt.rgba( 0.01, 0.01, 0.01, 1.0 )
			}
		}

		PlaneMesh {
			id: plane
		}
	}
}
