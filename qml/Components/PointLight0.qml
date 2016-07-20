import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "."

Entity {
	id: root
	components: [cube, transform, material, light]

	property color color: "white"
	property Transform transform: Transform {
		scale: .2
	}

	PointLight { // 1. ambient is not in light -> no addition, 2. quadratic attenuation model in gl3 shader only
		id: light
		color: root.color
		constantAttenuation: 1.
		linearAttenuation: .09
		quadraticAttenuation: .032
	}

	PhongMaterial {
		id: material
		ambient: root.color
	}

	CuboidMesh {
		id: cube
	}
}
