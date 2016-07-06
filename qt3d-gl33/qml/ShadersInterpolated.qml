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
														"qrc:/shared/shaders/shaders-interpolated.frag")
							}
						}
					}
				}
			}


			function copyArray(src, dst){
				for (var i in src) {
					dst[i] = src[i]
				}
			}

			Buffer {
				id: vertexBuffer
				type: Buffer.VertexBuffer
				data: (function () {
					var vertexArray = new Float32Array(3 * 6)
					var vertices = [
								0.5, -0.5, 0.0,  1.0, 0.0, 0.0,  // Bottom Right
							   -0.5, -0.5, 0.0,  0.0, 1.0, 0.0,  // Bottom Left
								0.0,  0.5, 0.0,  0.0, 0.0, 1.0   // Top
							]
					background.copyArray(vertices, vertexArray)
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
