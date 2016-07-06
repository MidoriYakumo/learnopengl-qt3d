import QtQuick 2.6 as QQ2
import QtQuick.Scene3D 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

Scene3D {
	id: scene
	height: 600
	width: 800

	Entity {
		id: root

		RenderSettings {
			id: renderSettings
			activeFrameGraph: ForwardRenderer {
				clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
			}
		}

		Entity {
			id: background
			components: [geometry, material]

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						filterKeys: FilterKey {
							name: "renderingStyle"
							value: "forward"
						}
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram {
								vertexShaderCode: loadSource(
									"file:../shared/shaders/hellotriangle.vert")
								fragmentShaderCode: loadSource(
									"file:../shared/shaders/hellotriangle.frag")
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

								for (var i in vertices) {
									vertexArray[i] = vertices[i]
								}

								return vertexArray;
							})()
						}
					}
				}

			}
		}
	}
}
