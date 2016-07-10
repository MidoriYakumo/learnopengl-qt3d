import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "misc.js" as Misc

Entity {
	id: box
	components: [geometry, transform, material]

	property int index: 0
	property Transform transform: Transform { }

	Material {
		id: material
		effect: Effect {
			techniques: Technique {
				renderPasses: RenderPass {
					renderStates: CullFace { mode: CullFace.NoCulling } // ignore normal vectors, result by tests
					shaderProgram: ShaderProgram0 {
						vertName: "coordinate_systems"
						fragName: "textures_combined"
					}
				}
			}

			parameters: [
				Parameter {
					name: "ourTexture1"
					value: Texture2D {
						TextureImage0 {
							fileName: "container.jpg"
						}
					}
				},
				Parameter {
					name: "ourTexture2"
					value: Texture2D {
						TextureImage0 {
							fileName: "awesomeface.png"
						}
					}
				}
			]
		}
	}

	Buffer {
		id: vertexBuffer
		type: Buffer.VertexBuffer
		data: (function () {
			var vertexArray = new Float32Array(5 * 36)
			var vertices = [
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
				-0.5,  0.5, -0.5,  0.0, 1.0
			]
			Misc.copyArray(vertices, vertexArray)
			return vertexArray
		})()
		}

	GeometryRenderer {
		id: geometry
		geometry: Geometry {
			Attribute {
				attributeType: Attribute.VertexAttribute
				vertexBaseType: Attribute.Float
				vertexSize: 3
				count: 36
				byteOffset: 0
				byteStride: 5 * 4
				name: defaultPositionAttributeName() // see src/QAttribute
				buffer: vertexBuffer
			}

			Attribute {
				attributeType: Attribute.VertexAttribute
				vertexBaseType: Attribute.Float
				vertexSize: 2
				count: 36
				byteOffset: 3 * 4
				byteStride: 5 * 4
				name: defaultTextureCoordinateAttributeName()
				buffer: vertexBuffer
			}

		}
	}
}
