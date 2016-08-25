import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene1 {
	Entity {
		id: root

		RenderSettings0 {}

		FrameSwap {}

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
										value: (function(){
											var m = Qt.matrix4x4()
											m.translate(Qt.vector3d(.5, -.5, 0))
											m.rotate(time0.value * 10, Qt.vector3d(0, 0, 1))
											return m
										})()

										Time {
											id: time0
											cycle: 360
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
									value: (function(){
										var m = Qt.matrix4x4()
										m.translate(Qt.vector3d(-.5, .5, 0))
										m.scale(Math.sin(time1.value))
										return m
									})()

									Time {
										id: time1
									}
								}
							}
						]
					}					
				}
			}

			components: [geometry, material]
		}
	}
}
