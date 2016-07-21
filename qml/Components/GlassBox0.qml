import Qt3D.Core 2.0
import Qt3D.Extras 2.0

Entity {
	id: cube
	components: [cubeMesh, material, transform]

	property int index: 0
	property vector3d axis
	property GlassPhongMaterial material: GlassPhongMaterial {
		ambient: "red"
		diffuse: "teal"
		specular: "skyblue"
		shininess: 32.
		refractive: 1./1.05
		transparency: 0.75
		skyboxTexture: skybox.skyboxTexture
	}

	CuboidMesh {
		id: cubeMesh
	}

	property Transform transform: Transform {
		rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .8), 60)
	}
}
