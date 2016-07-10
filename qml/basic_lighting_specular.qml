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
			components: [cube, phongMaterial]
		}

		Entity {
			components: [cube, objTransform, gouraudMaterial]
		}

		Entity {
			components: [cube, lampTransform, lampMaterial]
		}

		Transform {
			id: objTransform
			translation: Qt.vector3d(2.4, 0, 0)
		}

		property vector3d lightPos: Qt.vector3d(1.2, 1.0, 2.0)

		Transform {
			id: lampTransform
			translation: root.lightPos
			scale: .2
		}

		Material {
			id: phongMaterial
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram0 {
							vertName: "lighting_diffuse"
							fragName: "lighting_specular"
						}
					}
				}

				parameters: [
					Parameter { name: "objectColor"; value: Qt.vector3d(1., .5, .31) },
					Parameter { name: "lightColor"; value: Qt.vector3d(1., 1., 1.) },
					Parameter { name: "lightPos"; value: root.lightPos },
					Parameter { name: "viewPos"; value: settings.camera.position }
				]
			}
		}

		Material {
			id: gouraudMaterial
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram0 {
							vertName: "lighting_gouraud"
							fragName: "lighting_gouraud"
						}
					}
				}

				parameters: [
					Parameter { name: "objectColor"; value: Qt.vector3d(1., .5, .31) },
					Parameter { name: "lightColor"; value: Qt.vector3d(1., 1., 1.) },
					Parameter { name: "lightPos"; value: root.lightPos },
					Parameter { name: "viewPos"; value: settings.camera.position }
				]
			}
		}

		Material {
			id: lampMaterial
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram0 {
							vertName: "lighting_diffuse"
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
