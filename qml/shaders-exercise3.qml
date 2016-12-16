import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			TrianglePlane0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
								vertName: "shaders-exercise3"
								fragName: "shaders-interpolated"
							}
						}
					}
				}
			}

			components: [geometry, material]
		}
	}
}
