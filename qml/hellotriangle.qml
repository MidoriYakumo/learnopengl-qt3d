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
								vertName: "hellotriangle"
								fragName: "hellotriangle"
							}
						}
					}
				}
			}

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 3
						name: defaultPositionAttributeName()
						buffer: Buffer {
							type: Buffer.VertexBuffer
							data: (function buildBuffer(){
								var vertexArray = new Float32Array(3 * 3);
								var vertices = [-.5, -.5, 0, .5, -.5, 0, 0, .5, 0]
								Misc.copyArray(vertices, vertexArray)
								return vertexArray;
							})()
						}
					}
				}

			}
		}
	}
}
