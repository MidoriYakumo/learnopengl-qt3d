import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		gameButtonsEnabled: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space},
			]
		}
	}

	Entity {
		id: root

		RenderInputSettings0 {
			id: renderInputSettings

			mouseSensitivity: .5 / Units.dp
		}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			sourceDevice: keyboardDevice
			focus: true

			onSpacePressed: {
				root.useGouraudShader = !root.useGouraudShader;
				console.log("useGouraudShader:", root.useGouraudShader);
			}
		}

		property bool useGouraudShader: false

		property vector3d lightPos: "1.2, 1.0, 2.0"
		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor: "white"
		property color objectColor: "coral"

		CuboidMesh {
			id: mesh
		}

		Entity {
			id: object

			Transform {
				id: objectTransform
			}

			Material {
				id: objectMaterial
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: root.useGouraudShader?
										"basic_lighting_gouraud":
										"basic_lighting"
								fragName: root.useGouraudShader?
										"shaders-interpolated":
										"basic_lighting"
							}
							parameters: [
								Parameter {
									name: "lightPos"
									value: root.lightPos
								},
								Parameter {
									name: "viewPos"
									value: root.viewPos
								},
								Parameter {
									name: "lightColor"
									value: Qt.vector3d(
										root.lightColor.r,
										root.lightColor.g,
										root.lightColor.b
									)
								},
								Parameter {
									name: "objectColor"
									value: Qt.vector3d(
										root.objectColor.r,
										root.objectColor.g,
										root.objectColor.b
									)
								}
							]
						}
					}
				}
			}

			components: [mesh, objectTransform, objectMaterial]
		}

		Entity {
			id: lamp

			Transform {
				id: lampTransform
				translation: root.lightPos
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
