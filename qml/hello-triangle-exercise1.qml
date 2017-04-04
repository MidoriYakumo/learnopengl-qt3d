import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 6
						name: "position"
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: new Float32Array([
								// First triangle
								-0.9, -0.5, 0.0,  // Left
								-0.0, -0.5, 0.0,  // Right
								-0.45, 0.5, 0.0,  // Top
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
				id: material
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

			components: [geometry, material]
		}
	}
}
