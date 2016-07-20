import Qt3D.Core 2.0
import Qt3D.Extras 2.0

import "."

Entity {
	id: chest
	components: [cube, transform, material]

	CuboidMesh {
		id: cube
	}

	property Transform transform: Transform { }

	DiffuseSpecularMapMaterial {
		id: material

		ambient: Qt.rgba(.2, .2, .2, 1.)
		diffuse: Resources.texture("container2.png")
		specular: Resources.texture("container2_specular.png")
	}
}
