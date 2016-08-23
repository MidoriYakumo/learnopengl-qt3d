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
						count: 3
						name: "position" // Auto picked up for boundingPositionAttribute
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: (function buildBuffer(){
								var vertexArray = new Float32Array(3 * 3);
								var vertices = [-.5, -.5, 0, .5, -.5, 0, 0, .5, 0]
								Utils.copyArray(vertices, vertexArray)
								return vertexArray;
							})()
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
