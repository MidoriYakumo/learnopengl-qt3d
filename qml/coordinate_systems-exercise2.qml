import QtQuick 2.7 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import "Components"

QQ2.Item {
	height: 600
	width: 800

	Scene2 {
		id: scene
		anchors.fill: parent

		Entity {
			id: root

			RenderSettings {
				activeFrameGraph: ClearBuffers {
					buffers: ClearBuffers.ColorDepthBuffer
					clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
					RenderSurfaceSelector {
						RenderStateSet {
							renderStates: DepthTest {
								depthFunction: DepthTest.Less
							}
						}
					}
				}
			}

			InputSettings {}

			KeyboardDevice {
				id: keyboardDevice
			}

			KeyboardHandler {
				id: keyboardHandler
				focus: true
				onSpacePressed: {
					time.running = !time.running
				}
				sourceDevice: keyboardDevice
			}

			FrameSwap {}

			Time {
				id: time
			}

			property var cubePositions: [
				Qt.vector3d( 0.0,  0.0,  0.0),
				Qt.vector3d( 2.0,  5.0, -15.0),
				Qt.vector3d(-1.5, -2.2, -2.5),
				Qt.vector3d(-3.8, -2.0, -12.3),
				Qt.vector3d( 2.4, -0.4, -3.5),
				Qt.vector3d(-1.7,  3.0, -7.5),
				Qt.vector3d( 1.3, -2.0, -2.5),
				Qt.vector3d( 1.5,  2.0, -2.5),
				Qt.vector3d( 1.5,  0.2, -1.5),
				Qt.vector3d(-1.3,  1.0, -1.5)
			]

			NodeInstantiator {
				model: root.cubePositions
				delegate: Entity {
					property Transform transform: Transform {
						translation: modelData
						rotation: fromAxisAndAngle(Qt.vector3d(.5, 1, 0), 20 * index)
					}
					components: [geometry, material, transform]
				}
			}

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					boundingVolumePositionAttribute: position

					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 36
						byteOffset: 0
						byteStride: 4 * 5
						name: "position"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 36
						byteOffset: 4 * 3
						byteStride: 4 * 5
						name: "texCoord"
						buffer: vertexBuffer
					}
				}

				Buffer {
					id: vertexBuffer
					type: Buffer.VertexBuffer
					data: Float32Array([
					  -0.5, -0.5, -0.5,  0.0, 0.0,
					   0.5, -0.5, -0.5,  1.0, 0.0,
					   0.5,  0.5, -0.5,  1.0, 1.0,
					   0.5,  0.5, -0.5,  1.0, 1.0,
					  -0.5,  0.5, -0.5,  0.0, 1.0,
					  -0.5, -0.5, -0.5,  0.0, 0.0,

					  -0.5, -0.5,  0.5,  0.0, 0.0,
					   0.5, -0.5,  0.5,  1.0, 0.0,
					   0.5,  0.5,  0.5,  1.0, 1.0,
					   0.5,  0.5,  0.5,  1.0, 1.0,
					  -0.5,  0.5,  0.5,  0.0, 1.0,
					  -0.5, -0.5,  0.5,  0.0, 0.0,

					  -0.5,  0.5,  0.5,  1.0, 0.0,
					  -0.5,  0.5, -0.5,  1.0, 1.0,
					  -0.5, -0.5, -0.5,  0.0, 1.0,
					  -0.5, -0.5, -0.5,  0.0, 1.0,
					  -0.5, -0.5,  0.5,  0.0, 0.0,
					  -0.5,  0.5,  0.5,  1.0, 0.0,

					   0.5,  0.5,  0.5,  1.0, 0.0,
					   0.5,  0.5, -0.5,  1.0, 1.0,
					   0.5, -0.5, -0.5,  0.0, 1.0,
					   0.5, -0.5, -0.5,  0.0, 1.0,
					   0.5, -0.5,  0.5,  0.0, 0.0,
					   0.5,  0.5,  0.5,  1.0, 0.0,

					  -0.5, -0.5, -0.5,  0.0, 1.0,
					   0.5, -0.5, -0.5,  1.0, 1.0,
					   0.5, -0.5,  0.5,  1.0, 0.0,
					   0.5, -0.5,  0.5,  1.0, 0.0,
					  -0.5, -0.5,  0.5,  0.0, 0.0,
					  -0.5, -0.5, -0.5,  0.0, 1.0,

					  -0.5,  0.5, -0.5,  0.0, 1.0,
					   0.5,  0.5, -0.5,  1.0, 1.0,
					   0.5,  0.5,  0.5,  1.0, 0.0,
					   0.5,  0.5,  0.5,  1.0, 0.0,
					  -0.5,  0.5,  0.5,  0.0, 0.0,
					  -0.5,  0.5, -0.5,  0.0, 1.0
					])
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
								vertName: "coordinate_systems_qt3d_transform"
								fragName: "textures_combined"
							}
							parameters: [
								Parameter {
									name: "ourTexture1"
									value: Texture2D {
										generateMipMaps: true
										minificationFilter: Texture.Linear
										magnificationFilter: Texture.Linear
										wrapMode {
											x: WrapMode.Repeat
											y: WrapMode.Repeat
										}
										TextureImage {
											mipLevel: 0
											source: Resources.texture("container.jpg")
										}
									}
								},
								Parameter {
									name: "ourTexture2"
									value: Texture2D {
										generateMipMaps: true
										minificationFilter: Texture.Linear
										magnificationFilter: Texture.Linear
										wrapMode {
											x: WrapMode.Repeat
											y: WrapMode.Repeat
										}
										TextureImage {
											mipLevel: 0
											source: Resources.texture("awesomeface.png")
										}
									}
								},
								Parameter {
									name: "view"
									value: (function(){
										var m = Qt.matrix4x4()
										m.rotate(time.value % 360 * 180 / Math.PI, Qt.vector3d(0, 1, 0))
										m.translate(3*Math.sin(time.value), 0, -3*Math.cos(time.value))
										return m
									})()
								},
								Parameter {
									name: "projection"
									value: (function(){
										var fov = 45
										var aspect = scene.width / scene.height
										var zNear = .1
										var zFar = 100.
										var h = Math.tan(fov * Math.PI / 360) * zNear
										var w = h * aspect

										var m = Qt.matrix4x4()
										m.m11 = zNear / w
										m.m22 = zNear / h
										m.m33 = - (zNear + zFar) / (zFar - zNear)
										m.m43 = -1
										m.m34 = -2 * zNear * zFar / (zFar - zNear)
										return m
									})()
								}
							]
						}
					}
				}
			}
		}
	}

	VirtualKeys {
		target: scene
		targetHandler: keyboardHandler
		showPad: false
		keys: [
			{text:"Space", key:Qt.Key_Space}
		]
	}
}

