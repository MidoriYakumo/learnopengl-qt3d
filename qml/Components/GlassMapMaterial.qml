import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "."

Material {
	id: root

	property color ambient:  Qt.rgba( 0.05, 0.05, 0.05, 1.0 )
	property real shininess: 150.0
	property real textureScale: 1.0
	property real cappingSize: 0.1

	parameters: [
		Parameter { name: "ka"; value: Qt.vector3d(root.ambient.r, root.ambient.g, root.ambient.b) },
		Parameter { name: "cappingSize"; value: cappingSize },
		Parameter {
			name: "diffuseTexture"
			value: Texture2D {
				id: diffuseTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: diffuseTextureImage
					source: Resources.texture(diffuseName)
				}
			}
		},
		Parameter { name: "specularTexture";
			value: Texture2D {
				id: specularTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: specularTextureImage
					source: Resources.texture(specularName)
				}
			}
		},
		Parameter { name: "emissionTexture";
			value: Texture2D {
				id: emissionTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: emissionTextureImage
					source: Resources.texture(emissionName)
				}
			}
		},
		Parameter { name: "shininess"; value: root.shininess },
		Parameter { name: "texCoordScale"; value: textureScale }
	]

	effect: Effect {
		techniques: // OpenGL ES 2
			Technique {
				filterKeys: FilterKey {
						name: "renderingStyle"
						value: "forward"
					}
				renderPasses: [
					RenderPass {
						filterKeys: FilterKey { name: "pass"; value: "material" }
						renderStates: [
							CullFace { mode: CullFace.Back }
						]
						shaderProgram: ShaderProgram0 {
							vertName: "diffusemap"
							fragName: "diffusespecularemmisionmap"
						}
					},
					RenderPass {
						filterKeys: FilterKey { name: "pass"; value: "stencilFill" }
						renderStates: [
							CullFace { mode: CullFace.NoCulling }
						]
						shaderProgram: ShaderProgram0 {
							vertName: "glow"
							fragName: "glow"
						}
					}
				]
			}
	}

	property string diffuseName
	property string specularName
	property string emissionName
}
