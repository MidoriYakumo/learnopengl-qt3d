import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		targetHandler: keyboardHandler
		padEnabled: false
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

		RenderSettings0 {}

		FrameSwap {}

		InputSettings {}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			focus: true
			sourceDevice: keyboardDevice
			onSpacePressed: time.running = !time.running
		}

		Entity {
			id: plane

			TextureRectanglePlane0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: AutoShaderProgram {
								vertName: "transformations"
								fragName: "textures_combined"
							}
						}
					}
				}

				parameters: [
					Parameter {
						name: "ourTexture1"
						value: Texture2D {
							generateMipMaps: true
							minificationFilter: Texture.Linear
							magnificationFilter: Texture.Linear
							wrapMode {
								x: WrapMode.Repeat
								y: WrapMode.Repeat
							}
							TextureImage {
								mipLevel: 0
								source: Resources.texture("container.jpg")
							}
						}
					},
					Parameter {
						name: "ourTexture2"
						value: Texture2D {
							generateMipMaps: true
							minificationFilter: Texture.Linear
							magnificationFilter: Texture.Linear
							wrapMode {
								x: WrapMode.Repeat
								y: WrapMode.Repeat
							}
							TextureImage {
								mipLevel: 0
								source: Resources.texture("awesomeface.png")
							}
						}
					},
					Parameter {
						name: "transform"
						value: { // Order changed
							var m = Qt.matrix4x4();
							m.rotate(time.value % 360 * 50, Qt.vector3d(0, 0, 1));
							m.translate(Qt.vector3d(0.5, -0.5, 0.0));
							return m;
						}

						Time {
							id: time
						}
					}
				]
			}

			components: [geometry, material]
		}
	}
}
