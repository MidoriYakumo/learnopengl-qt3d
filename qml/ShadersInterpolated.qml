import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "misc.js" as Misc

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: background
			components: [geometry, material]

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram0 {
								vertName: "shaders-uniform"
								fragName: "shaders-interpolated"
							}
						}
					}
				}
			}

			Buffer {
				id: vertexBuffer
				type: Buffer.VertexBuffer
				data: (function () {
					var vertexArray = new Float32Array(3 * 6)
					var vertices = [
						0.5, -0.5, 0.0, 1.0, 0.0, 0.0, // Bottom Right
						-0.5, -0.5, 0.0, 0.0, 1.0, 0.0, // Bottom Left
						0.0, 0.5, 0.0, 0.0, 0.0, 1.0 // Top
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
						count: 3
						byteOffset: 0
						byteStride: 6 * 4
						name: defaultPositionAttributeName()
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 3
						byteOffset: 3 * 4
						byteStride: 6 * 4
						name: "color"
						buffer: vertexBuffer
					}
				}
			}
		}
	}
}
