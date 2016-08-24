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
				// #TRYIT: Commenting this option will result in filling polygons
				primitiveType: GeometryRenderer.LineLoop // Currently linewidth=1 only
				geometry: Geometry {
					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						name: "position"
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: Float32Array([
									0.5,  0.5, 0.0,  // Top Right
									0.5, -0.5, 0.0,  // Bottom Right
								   -0.5, -0.5, 0.0,  // Bottom Left
								   -0.5,  0.5, 0.0   // Top Left
								])
						}
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
					boundingVolumePositionAttribute: position // Manual setting positionAttribute
				}
			}

            Material {
                id: material
                effect: Effect {
                    techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling } // By default Qt3D culls back faces
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
