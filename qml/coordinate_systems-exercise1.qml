import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene3 {
	id: scene
	children: VirtualKeys {
		target: scene
		gameButtonsEnabled: false
		color: "transparent"
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
			focus: true
			onUpPressed: {
				root.fov = Geo.mix(root.fov, 0., 0.1);
				console.log("fov:", root.fov);
			}
			onDownPressed: {
				root.fov = Geo.mix(root.fov, 180., 0.1);
				console.log("fov:", root.fov);
			}
			onLeftPressed: {
				root.aspectRatio = Geo.mix(root.aspectRatio, 1e-1, 0.1);
				console.log("aspectRatio:", root.aspectRatio);
			}
			onRightPressed: {
				root.aspectRatio = Geo.mix(root.aspectRatio, 1e1, 0.1);
				console.log("aspectRatio:", root.aspectRatio);
			}
			sourceDevice: keyboardDevice
		}

		property real fov: 45
		property real aspectRatio: scene.width/scene.height
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
					rotation: fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), 20 * index)
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
									var zNear = .1;
									var zFar = 100.;
									var h = Math.tan(root.fov * Math.PI / 360) * zNear;
									var w = h * root.aspectRatio;

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
