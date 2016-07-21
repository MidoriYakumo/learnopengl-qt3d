import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Entity {
	id: cube
	components: [cubeMesh, material, transform]

	property int index: 0
	property vector3d axis

	property Material material: Material {
		effect: Effect {
			techniques: Technique {
				filterKeys:FilterKey {
					id: forward
					name: "renderingStyle"
					value: "forward"
				}
				renderPasses: RenderPass {
					renderStates: CullFace { mode: CullFace.NoCulling }
					shaderProgram: ShaderProgram0 {
						vertName: "glsltest"
						fragName: "glsltest"
					}
				}
			}
		}
	}

	CuboidMesh {
		id: cubeMesh
	}

	property Transform transform: Transform {
		rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .8), 60)
	}
}
