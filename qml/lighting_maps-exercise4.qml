import QtQuick 2.9

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: [
		VirtualKeys {
			target: scene
			gameButtonsEnabled: false
			color: "transparent"
		},
		Time {
			id: time
		}
	]

	Entity {
		id: root

		RenderInputSettings0 {
			id: renderInputSettings

			mouseSensitivity: .5 / Units.dp
		}

		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor: "white"
		property Entity material: Entity {
			property Texture2D diffuseMap: Texture2D {
				TextureImage {
					source: Resources.texture("container2.png")
				}
			}

			property Texture2D specularMap: Texture2D {
				TextureImage {
					source: Resources.texture("container2_specular.png")
				}
			}

			property Texture2D emissionMap: Texture2D {
				wrapMode.y: WrapMode.Repeat

				TextureImage {
					source: Resources.texture("matrix.jpg")
				}
			}

			property real shininess: 32.
		}

		QtObject {
			id: light

			property vector3d position: "1.2, 1.0, 2.0"

			property vector3d ambient: "0.2, 0.2, 0.2"
			property vector3d diffuse: "0.5, 0.5, 0.5"
			property vector3d specular: "1.0, 1.0, 1.0"
		}

		CuboidMesh {
			id: mesh
		}

		Entity {
			id: object

			Transform {
				id: objectTransform
			}

			Material {
				id: ourMaterial
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: "lighting_maps"
								fragName: "lighting_maps-exercise4"
							}
							parameters: [
								Parameter {
									name: "time"
									value: time.value
								},
								Parameter {
									name: "viewPos"
									value: root.viewPos
								},
								Parameter {
									name: "material.diffuse"
									value: root.material.diffuseMap
								},
								Parameter {
									name: "material.specular"
									value: root.material.specularMap
								},
								Parameter {
									name: "material.emission"
									value: root.material.emissionMap
								},
								Parameter {
									name: "material.shininess"
									value: root.material.shininess
								},
								Parameter {
									name: "light.position"
									value: light.position
								},
								Parameter {
									name: "light.ambient"
									value: light.ambient
								},
								Parameter {
									name: "light.diffuse"
									value: light.diffuse
								},
								Parameter {
									name: "light.specular"
									value: light.specular
								}
							]
						}
					}
				}
			}

			components: [mesh, objectTransform, ourMaterial]
		}

		Entity {
			id: lamp

			Transform {
				id: lampTransform
				translation: light.position
				scale: .2
			}

			Material {
				id: lampMaterial
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: "basic_lighting"
								fragName: "shaders-uniform"
							}
							parameters: [
								Parameter {
									name: "ourColor"
									value: root.lightColor
								}
							]
						}
					}
				}
			}

			components: [mesh, lampTransform, lampMaterial]
		}
	}
}
