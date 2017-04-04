import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: plane

		RenderSettings0 {}

		GeometryRenderer {
			id: geometry0
			geometry: Geometry {
				Attribute {
					attributeType: Attribute.VertexAttribute
					vertexBaseType: Attribute.Float
					vertexSize: 3
					count: 3
					name: "position"
					buffer: Buffer {
						type: Buffer.VertexBuffer
						data: new Float32Array([
							// First triangle
							-0.9, -0.5, 0.0,  // Left
							-0.0, -0.5, 0.0,  // Right
							-0.45, 0.5, 0.0,  // Top
						])
					}
				}
			}
		}

		GeometryRenderer {
			id: geometry1
			geometry: Geometry {
				Attribute {
					attributeType: Attribute.VertexAttribute
					vertexBaseType: Attribute.Float
					vertexSize: 3
					count: 3
					name: "position" // Auto picked up for boundingPositionAttribute
					buffer: Buffer {
						type: Buffer.VertexBuffer
						data: new Float32Array([
							// Second triangle
							0.0, -0.5, 0.0,  // Left
							0.9, -0.5, 0.0,  // Right
							0.45, 0.5, 0.0,  // Top
						])
					}
				}
			}
		}

		Material {
			id: material0
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram {
							vertexShaderCode: loadSource(Resources.shader("hellotriangle.vert"))
							fragmentShaderCode: loadSource(Resources.shader("hellotriangle.frag"))
						}
					}
				}
			}
		}

		Material {
			id: material1
			effect: Effect {
				techniques: Technique {
					renderPasses: RenderPass {
						shaderProgram: ShaderProgram {
							// ShaderCodes are bytes! We need javascript strings!
							vertexShaderCode: loadSource(Resources.shader("hellotriangle.vert"))
							fragmentShaderCode: loadSource(Resources.shader("hellotriangle.frag"))
									.toString().replace(".5","1.").replace(".2", "0.")
						}
					}
				}
			}
		}

		// Two triangles with two materials/shaders

		Entity {
			id: triangle0
			components: [geometry0, material0]
		}

		Entity {
			id: triangle1
			components: [geometry1, material1]
		}
	}
}
