import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "."

Entity {
	id: cube

	property Transform transform: Transform {} // default: origin

	property matrix4x4 viewMatrix: Qt.matrix4x4()
	property matrix4x4 projectionMatrix: Qt.matrix4x4()

	GeometryRenderer {
		id: geometry
		geometry: Geometry {
			boundingVolumePositionAttribute: position

			Attribute {
				id: position
				attributeType: Attribute.VertexAttribute
				vertexBaseType: Attribute.Float
				vertexSize: 3
				count: 36
				byteOffset: 0
				byteStride: 4 * 5
				name: "position"
				buffer: vertexBuffer
			}

			Attribute {
				attributeType: Attribute.VertexAttribute
				vertexBaseType: Attribute.Float
				vertexSize: 2
				count: 36
				byteOffset: 4 * 3
				byteStride: 4 * 5
				name: "texCoord"
				buffer: vertexBuffer
			}
		}

		Buffer {
			id: vertexBuffer
			type: Buffer.VertexBuffer
			data: new Float32Array([
				-0.5, -0.5, -0.5,  0.0, 0.0,
				 0.5, -0.5, -0.5,  1.0, 0.0,
				 0.5,  0.5, -0.5,  1.0, 1.0,
				 0.5,  0.5, -0.5,  1.0, 1.0,
				-0.5,  0.5, -0.5,  0.0, 1.0,
				-0.5, -0.5, -0.5,  0.0, 0.0,

				-0.5, -0.5,  0.5,  0.0, 0.0,
				 0.5, -0.5,  0.5,  1.0, 0.0,
				 0.5,  0.5,  0.5,  1.0, 1.0,
				 0.5,  0.5,  0.5,  1.0, 1.0,
				-0.5,  0.5,  0.5,  0.0, 1.0,
				-0.5, -0.5,  0.5,  0.0, 0.0,

				-0.5,  0.5,  0.5,  1.0, 0.0,
				-0.5,  0.5, -0.5,  1.0, 1.0,
				-0.5, -0.5, -0.5,  0.0, 1.0,
				-0.5, -0.5, -0.5,  0.0, 1.0,
				-0.5, -0.5,  0.5,  0.0, 0.0,
				-0.5,  0.5,  0.5,  1.0, 0.0,

				 0.5,  0.5,  0.5,  1.0, 0.0,
				 0.5,  0.5, -0.5,  1.0, 1.0,
				 0.5, -0.5, -0.5,  0.0, 1.0,
				 0.5, -0.5, -0.5,  0.0, 1.0,
				 0.5, -0.5,  0.5,  0.0, 0.0,
				 0.5,  0.5,  0.5,  1.0, 0.0,

				-0.5, -0.5, -0.5,  0.0, 1.0,
				 0.5, -0.5, -0.5,  1.0, 1.0,
				 0.5, -0.5,  0.5,  1.0, 0.0,
				 0.5, -0.5,  0.5,  1.0, 0.0,
				-0.5, -0.5,  0.5,  0.0, 0.0,
				-0.5, -0.5, -0.5,  0.0, 1.0,

				-0.5,  0.5, -0.5,  0.0, 1.0,
				 0.5,  0.5, -0.5,  1.0, 1.0,
				 0.5,  0.5,  0.5,  1.0, 0.0,
				 0.5,  0.5,  0.5,  1.0, 0.0,
				-0.5,  0.5,  0.5,  0.0, 0.0,
				-0.5,  0.5, -0.5,  0.0, 1.0,
			])
		}
	}

	Material {
		id: material
		effect: Effect {
			techniques: Technique {
				renderPasses: RenderPass {
					shaderProgram: ShaderProgram0 {
						vertName: "coordinate_systems_qt3d_transform"
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
							name: "view"
							value: cube.viewMatrix
						},
						Parameter {
							name: "projection"
							value: cube.projectionMatrix
						}
					]
				}
			}
		}
	}

	components: [geometry, material, transform]
}
