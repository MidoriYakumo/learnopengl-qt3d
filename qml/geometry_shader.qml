import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings1 {
			id: riss
		}

		Entity {
			components: [mesh, transform, material]

			Transform {
				id: transform
				translation: Qt.vector3d(-4, -8, -20)
				rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .2), 45)
			}

			Mesh {
				id: mesh
				source: Resources.model("nanosuit.obj")
			}

			Material {
				id: material
				property real timeValue: 0
				QQ2.NumberAnimation {
					target: material
					property: "timeValue"
					duration: 5000
					from: 0
					to: Math.PI * 2

					loops: QQ2.Animation.Infinite
					running: true
				}

				effect: Effect {
					techniques: Technique {
						filterKeys: FilterKey {
							id: forward
							name: "renderingStyle"
							value: "forward"
						}
						renderPasses: [
							RenderPass {
								shaderProgram: ShaderProgram {
									vertexShaderCode: loadSource(Resources.shader("passthrough.vert"))
									fragmentShaderCode: loadSource(Resources.shader("passthrough.frag"))
								}
							},
							RenderPass {
								shaderProgram: ShaderProgram {
									vertexShaderCode: loadSource(Resources.shader("hair.vert"))
									fragmentShaderCode: loadSource(Resources.shader("hair.frag"))
									geometryShaderCode:  loadSource(Resources.shader("hair.geom"))
								}
							}
						]
					}

					parameters: [
						Parameter {
							name: "texture"
							value: Texture2D {
								minificationFilter: Texture.LinearMipMapLinear
								magnificationFilter: Texture.Linear
								wrapMode {
									x: WrapMode.Repeat
									y: WrapMode.Repeat
								}
								generateMipMaps: true
								maximumAnisotropy: 16.0
								TextureImage {
									source: Resources.texture("container.jpg")
								}
							}
						},
						Parameter {
							name: "time"
							value: material.timeValue
						}
					]

				}
			}
		}
	}
}
