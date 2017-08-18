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
					// Now we have two attributes
					boundingVolumePositionAttribute: position // Manually set bounding volume

					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						name: "position"
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: new Float32Array([
								0.5,  0.5, 0.0,  // Top Right
								0.5, -0.5, 0.0,  // Bottom Right
							   -0.5, -0.5, 0.0,  // Bottom Left
							   -0.5,  0.5, 0.0,  // Top Left
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
							data: new Uint16Array([
								0, 1, 3,  // First Triangle
								1, 2, 3,   // Second Triangle
							])
						}
					}
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							/*
								By default Qt3D culls back faces, here we need to disable it
								to render triangles in any vertex order
							*/

							renderStates: // Source: qt3d/src/render/renderstates/renderstates.cpp ?
								CullFace {
									/*
										Cull face setting
										Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qcullface.html
									*/

									mode: CullFace.NoCulling
								}
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
