import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings0 { }

		Entity {
			components: [cube, objTransform, objMaterial]
		}

		Entity {
			components: [cube, lampTransform, lampMaterial]
		}

		Transform {
			id: objTransform
		}

		Transform {
			id: lampTransform
			translation: Qt.vector3d(1.2, 1.0, 2.0)
			scale: .2
		}

		Material {
			id: objMaterial
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						renderStates: CullFace { mode: CullFace.NoCulling }
						shaderProgram: ShaderProgram0 {
							vertName: "coordinate_systems"
							fragName: "lighting"
						}
					}
				}

				parameters: [
					Parameter {
						name: "objectColor"
						value: Qt.vector3d(1., .5, .31)
					},
					Parameter {
						name: "lightColor"
						value: Qt.vector3d(1., .5, 1.)
					}
				]
			}
		}

		Material {
			id: lampMaterial
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						renderStates: CullFace { mode: CullFace.NoCulling }
						shaderProgram: ShaderProgram0 {
							vertName: "coordinate_systems"
							fragName: "lamp"
						}
					}
				}
			}
		}


		CuboidMesh {
			id: cube
		}
	}
}
