import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene1 {
	Entity {
		id: root

		RenderSettings0 {}

		FrameSwap {}

		Entity {
			id: plane

			TrianglePlane0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: AutoShaderProgram {
								vertName: "shaders-exercise2"
								fragName: "shaders-uniform"
							}
						}
					}
				}

				parameters: [
					Parameter {
						name: "ourColor"
						value: Qt.rgba(0, greenValue, 0, 1)

						property real greenValue: (Math.sin(time.value) / 2.) + .5
					},
					Parameter {
						name: "xOffset"
						value: Math.sin(time.value) / 2.
					}
				]
			}

			components: [geometry, material]
		}

		Time {
			id: time
		}
	}
}
