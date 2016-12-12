import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import "Components"
import "VirtualKey"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		enableGameButtons: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space},
				{text:"Return", key:Qt.Key_Return}
			]
		}
	}

	Entity {
		id: root

		RenderInputSettings0 {
			mouseSensitivity: 0.5 / Units.dp
		}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			sourceDevice: keyboardDevice
			focus: true

			onSpacePressed: {
				root.makeTransformHomo = !root.makeTransformHomo;
				console.log("makeTransformHomo:", root.makeTransformHomo);
			}

			onReturnPressed: {
				root.makeCubeRotate = !root.makeCubeRotate;
				console.log("makeCubeRotate:", root.makeCubeRotate);
			}
		}

		property bool makeTransformHomo: true
		property bool makeCubeRotate: false

		property vector3d lightPos: "1.2, 1.0, 2.0"
		property color lightColor: "white"
		property color objectColor: "coral"

		CuboidMesh {
			id: mesh
		}

		Entity {
			id: object

			Transform {
				id: objectTransform
				// //#TRYIT: Uncomment this and toggle makeTransformHomo
				rotation: root.makeCubeRotate?
						fromAxisAndAngle(Qt.vector3d(.5, 1, 0), 60):
						Qt.quaternion(0,0,0,0)
			}

			Material {
				id: objectMaterial
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
								vertName: root.makeTransformHomo?"basic_lighting":"basic_lighting_no_normal_fix"
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
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
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
