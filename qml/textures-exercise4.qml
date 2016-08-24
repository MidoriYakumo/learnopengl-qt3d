import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import "Components"

Scene0 {
	focus: true // as InputSettings.eventSource, see examples/controls
	aspects: ["input"]

	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					boundingVolumePositionAttribute: position

					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 0
						byteStride: 8 * 4
						name: "position"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 3 * 4
						byteStride: 8 * 4
						name: "color"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 4
						byteOffset: 6 * 4
						byteStride: 8 * 4
						name: "texCoord"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: Uint16Array([
									0, 1, 3,  // First Triangle
									1, 2, 3   // Second Triangle
								])
						}
					}
				}

				Buffer {
					id: vertexBuffer
					type: Buffer.VertexBuffer
					data: Float32Array([
							// Positions      // Colors        // Texture Coords
							 0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // Top Right
							 0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // Bottom Right
							-0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // Bottom Left
							-0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0  // Top Left
						])
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram0 {
								vertName: "textures_combined"
								fragName: "textures-exercise4"
							}
						}
					}

					parameters: [
						Parameter {
							name: "ourTexture1"
							value: Texture2D { // #TRYIT: change filtering mode
								generateMipMaps: true
								minificationFilter: Texture.Linear
								magnificationFilter: Texture.Linear
								wrapMode { // #TRYIT: change wrap mode
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
							value: Texture2D { // #TRYIT: change filtering mode
								generateMipMaps: true
								minificationFilter: Texture.Linear
								magnificationFilter: Texture.Linear
								wrapMode { // #TRYIT: change wrap mode
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
							name: "mixValue"
							value: root.mixValue
						}
					]
				}
			}

			components: [geometry, material]
		}

		property real mixValue: .5

		InputSettings {}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			focus: true
			onUpPressed: root.mixValue = Utils.mix(root.mixValue, 1., .1)
			onDownPressed: root.mixValue = Utils.mix(root.mixValue, 0., .1)
			sourceDevice: keyboardDevice
		}
	}
}
