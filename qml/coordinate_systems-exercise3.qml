import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		targetHandler: keyboardHandler
		padEnabled: false
		gameButtonsEnabled: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space},
			]
		}
	}

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
				time.running = !time.running;
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
			Qt.vector3d(-1.3,  1.0, -1.5),
		]

		NodeInstantiator {
			model: root.cubePositions
			delegate: Entity {
				property Transform transform: Transform {
					translation: modelData
					rotation: index%3?
							fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), 20 * index):
							fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), time.value % 360 * 20 * index)
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
				data: new Float32Array([
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
				  -0.5,  0.5, -0.5,  0.0, 1.0,
				])
			}
		}

		Material {
			id: material
			effect: Effect {
				techniques: AutoTechnique {
					renderPasses: RenderPass {
						shaderProgram: AutoShaderProgram {
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
								value: {
									var m = Qt.matrix4x4();
									m.translate(0, 0, -3);
									return m;
								}
							},
							Parameter {
								name: "projection"
								value: {
									var fov = 45;
									var aspect = scene.width / scene.height;
									var zNear = .1;
									var zFar = 100.;
									var h = Math.tan(fov * Math.PI / 360) * zNear;
									var w = h * aspect;

									var m = Qt.matrix4x4();
									m.m11 = zNear / w;
									m.m22 = zNear / h;
									m.m33 = - (zNear + zFar) / (zFar - zNear);
									m.m34 = -2 * zNear * zFar / (zFar - zNear);
									m.m43 = -1;
									m.m44 = 0;
									return m;
								}
							}
						]
					}
				}
			}
		}
	}
}
