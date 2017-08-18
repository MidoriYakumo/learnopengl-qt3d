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
				{text:"Return", key:Qt.Key_Return},
			]
		}
	}

	Entity {
		id: root

		RenderInputSettings0 {
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
				root.enableNormalRecalculate = !root.enableNormalRecalculate;
				console.log("enableNormalRecalculate:", root.enableNormalRecalculate);
			}

			onReturnPressed: {
				root.cuboidNonUniformScaled = !root.cuboidNonUniformScaled;
				console.log("cuboidNonUniformScaled:", root.cuboidNonUniformScaled);
			}
		}

		property bool enableNormalRecalculate: true
		property bool cuboidNonUniformScaled: false

		property vector3d lightPos: "1.2, 1.0, 2.0"
		property color lightColor: "white"
		property color objectColor: "coral"


		Entity {
			id: object

			NonUniformScaledCuboidMesh0 {
				/*
					As Qt ignores non-uniform scaling, vetices is needed to be
					processed to display the difference with or without normal
					fix.
				*/

				id: objectMesh
				fixNormal: root.enableNormalRecalculate
				matrix: root.cuboidNonUniformScaled?
						Qt.matrix4x4(
							Math.random() + .2, Math.random(), Math.random(), Math.random()*2-1,
							Math.random(), Math.random() + .2, Math.random(), Math.random()*2-1,
							Math.random(), Math.random(), Math.random() + .2, Math.random()*2-1,
							0, 0, 0, 1
						):
						Qt.matrix4x4()
			}

			Material {
				id: objectMaterial
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: "basic_lighting"
								fragName: "basic_lighting_diffuse"
							}
							parameters: [
								Parameter {
									name: "lightPos"
									value: root.lightPos
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

			components: [objectMesh, objectMaterial]
		}

		Entity {
			id: lamp

			CuboidMesh {
				id: lampMesh
			}

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

			components: [lampMesh, lampTransform, lampMaterial]
		}
	}
}
