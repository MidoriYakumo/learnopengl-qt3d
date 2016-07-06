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
			activeFrameGraph: ClearBuffers {
				buffers: ClearBuffers.ColorDepthBuffer
				clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
				RenderSurfaceSelector {
				}
			}
		}

		Entity {
			id: background
			components: [geometry, material]

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram {
								vertexShaderCode: loadSource(
													  "qrc:/shared/shaders/shaders-uniform.vert")
								fragmentShaderCode: loadSource(
														"qrc:/shared/shaders/shaders-uniform.frag")
							}
						}
					}
					parameters: Parameter {
						id: parameters
						name: "ourColor";
						value: Qt.vector4d(0, greenValue, 0, 1)
						property real greenValue: (Math.sin(timeValue) / 2.) + 0.5
						property real timeValue

						QQ2.NumberAnimation {
							target: parameters
							property: "timeValue"
							duration: Math.PI * 2000
							from: 0
							to: Math.PI * 2

							loops: QQ2.Animation.Infinite
							running: true
						}
					}
				}
			}


			function copyArray(src, dst){
				for (var i in src) {
					dst[i] = src[i]
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
							data: (function () {
								var vertexArray = new Float32Array(3 * 3)
								var vertices = [-.5, -.5, 0, .5, -.5, 0, 0, .5, 0]
								background.copyArray(vertices, vertexArray)
								return vertexArray
							})()
						}
					}
				}
			}
		}
	}
}
