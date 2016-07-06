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
				buffers: ClearBuffers.ColorDepthBuffer // MUST HAVE Depth? -> NoCulling
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
													  "file:../shared/shaders/hellotriangle.vert")
								fragmentShaderCode: loadSource(
														"file:../shared/shaders/hellotriangle.frag")
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
								background.copyArray(vertices, vertexArray)
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
								background.copyArray(indices, indexArray)
								return indexArray
							})()
						}
					}
				}
			}
		}
	}
}
