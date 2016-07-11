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
			components: [cube, lampTransform, lampMaterial]
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
				id: effect
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram0 {
							vertName: "lighting_diffuse"
							fragName: "materials"
						}
					}
				}

				parameters: [
					Parameter { name: "material.ambient"; value: Qt.vector3d(1., .5, .31) },
					Parameter { name: "material.diffuse"; value: Qt.vector3d(1., .5, .31) },
					Parameter { name: "material.specular"; value: Qt.vector3d(.5, .5, .5) },
					Parameter { name: "material.shininess"; value: 32. },

					Parameter { name: "light.ambient"; value: effect.ambientColor },
					Parameter { name: "light.diffuse"; value: effect.diffuseColor },
					Parameter { name: "light.specular"; value: Qt.vector3d(1., 1., 1.) },

					Parameter { name: "light.position"; value: root.lightPos },
					Parameter { name: "viewPos"; value: settings.camera.position }
				]

				property color lightColor
				property color ambientColor: Qt.rgba(lightColor.r*.2, lightColor.g*.2, lightColor.b*.2, 1.)
				property color diffuseColor: Qt.rgba(lightColor.r*.5, lightColor.g*.5, lightColor.b*.5, 1.)

				QQ2.SequentialAnimation {
					loops: QQ2.Animation.Infinite
					running: true
					QQ2.ColorAnimation {
						target: effect
						property: "lightColor"
						duration: 2000
						from: "red"
						to: "green"
					}
					QQ2.ColorAnimation {
						target: effect
						property: "lightColor"
						duration: 2000
						from: "green"
						to: "blue"
					}
					QQ2.ColorAnimation {
						target: effect
						property: "lightColor"
						duration: 2000
						from: "blue"
						to: "red"
					}
				}
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
