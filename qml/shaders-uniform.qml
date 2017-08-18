import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene1 {
	// Extra configs for FPS indicator

	Entity {
		id: root

		RenderSettings0 {}

		FrameSwap {} // My FPS counter injection

		Entity {
			id: plane

			TrianglePlane0 {
				id: geometry
			}

			Material {
				/*
					Shader uniform can be set in either:
						Material:
							qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qmaterial.html
						Effect:
							qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qeffect.html
						Technique:
							qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qtechnique.html
						RenderPass:
							qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qrenderpass.html
					But in different progress of rendering(see later examples).
				*/

				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: "shaders-uniform"
								fragName: "shaders-uniform"
							}
						}
					}
				}

				parameters: Parameter {
					id: ourColor
					name: "ourColor"
					value: Qt.rgba(0, greenValue, 0, 1)

					property real greenValue: (Math.sin(time.value) / 2.) + .5

					Time { // My time animation generator
						id: time
					}
				}
			}

			components: [geometry, material]
		}
	}
}
