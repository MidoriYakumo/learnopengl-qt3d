import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import "Components"
import "VirtualKey"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		targetHandler: keyboardHandler
		enablePad: false
		enableGameButtons: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space}
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

			TextureRectangleGeometry0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: [ // Two render passes
							RenderPass {
								renderStates: CullFace { mode: CullFace.NoCulling }
								shaderProgram: ShaderProgram0 {
									vertName: "transformations"
									fragName: "textures_combined"
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
										value: {
											var m = Qt.matrix4x4()
											m.translate(Qt.vector3d(.5, -.5, 0))
											m.rotate(time.value % 360  * 10, Qt.vector3d(0, 0, 1))
											return m
										}
									}
								]
							},
							RenderPass {
								renderStates: CullFace { mode: CullFace.NoCulling }
								shaderProgram: ShaderProgram0 {
									vertName: "transformations"
									fragName: "textures_combined"
								}

								parameters: Parameter {
									name: "transform"
									value: {
										var m = Qt.matrix4x4()
										m.translate(Qt.vector3d(-.5, .5, 0))
										m.scale(Math.sin(time.value))
										return m
									}
								}
							}
						]
					}
				}
			}

			components: [geometry, material]
		}

		Time {
			id: time
		}
	}
}
