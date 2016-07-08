import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"
import "Components/misc.js" as Misc

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
							shaderProgram: ShaderProgram0 {
								vertName: "hellotriangle"
								fragName: "hellotriangle"
							}
						}
					}
				}
			}

			GeometryRenderer {
				id: geometry
				primitiveType: GeometryRenderer.LineLoop
				geometry: Geometry {
					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						name: defaultPositionAttributeName()
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: (function () {
								var vertexArray = new Float32Array(3 * 4)
								var vertices = [
											0.5,  0.5, 0.0,  // Top Right
											0.5, -0.5, 0.0,  // Bottom Right
										   -0.5, -0.5, 0.0,  // Bottom Left
										   -0.5,  0.5, 0.0   // Top Left
										]
								Misc.copyArray(vertices, vertexArray)
								return vertexArray
							})()
						}
					}
					Attribute {
						attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: (function () {
								var indexArray = new Uint16Array(3 * 2)
								var indices = [
											0, 1, 3,  // First Triangle
											1, 2, 3   // Second Triangle
										]
								Misc.copyArray(indices, indexArray)
								return indexArray
							})()
						}
					}
				}
			}
		}
	}
}
