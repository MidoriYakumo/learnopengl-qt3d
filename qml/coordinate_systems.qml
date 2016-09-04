import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			TextureRectangleGeometry0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram0 {
								vertName: "coordinate_systems"
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
						name: "model"
						value: (function(){
							var m = Qt.matrix4x4()
							m.rotate(-55, Qt.vector3d(1, 0, 0))
							return m
						})()
					},
					Parameter {
						name: "view"
						value: (function(){
							var m = Qt.matrix4x4()
							m.translate(0, 0, -3)
							return m
						})()
					},
					Parameter {
						name: "projection"
						value: (function(){
							var fov = 45
							var aspect = scene.width / scene.height
							var zNear = .1
							var zFar = 100.
							var h = Math.tan(fov * Math.PI / 360) * zNear
							var w = h * aspect

							var m = Qt.matrix4x4()
							m.m11 = zNear / w
							m.m22 = zNear / h
							m.m33 = - (zNear + zFar) / (zFar - zNear)
							m.m43 = -1
							m.m34 = -2 * zNear * zFar / (zFar - zNear)
							return m
						})()
					}
				]
			}

			components: [geometry, material]
		}
	}
}
