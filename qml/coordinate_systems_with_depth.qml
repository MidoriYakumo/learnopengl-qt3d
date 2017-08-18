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
				{text:"Return", key:Qt.Key_Return},
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
						id: renderStateSet
						renderStates: DepthTest {
							/*
								Let's explicitly enable depth test now
								Use depthFunction to decide which compared result to be shown
								Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qdepthtest.html
							*/

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

		property bool useQtTransform: false
		property bool enableDepthTest: true
		property var storeDepthTest

		KeyboardHandler {
			/*
				Space to toggle depth test
				Return to toggle the usage of Qt3D Transform
			*/

			id: keyboardHandler
			focus: true
			onSpacePressed: {
				root.enableDepthTest = !root.enableDepthTest;
				if (root.enableDepthTest) {
					renderStateSet.renderStates = [root.storeDepthTest];
				} else {
					root.storeDepthTest = renderStateSet.renderStates[0];
					renderStateSet.renderStates = [];
				}

				console.log("enableDepthTest:", root.enableDepthTest);
			}
			onReturnPressed: {
				root.useQtTransform = !root.useQtTransform;
				console.log("useQtTransform:", root.useQtTransform);
			}
			sourceDevice: keyboardDevice
		}

		FrameSwap {}

		Entity {
			id: cube

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

			Transform {
				/*
					This is Qt3D internal transform QML
					It is what "model" is in renderer
					With several Transform cascaded in QML
					the final modelMatrix is the product of all transform matrix in order,
					so you need no longer multiple them by yourself
					The internal uniform names can be found in:
						qt3d/src/render/backend/renderview.cpp:137
				*/

				id: transform

				matrix: { // modelMatrix
					var m = Qt.matrix4x4();
					m.rotate(time.value % 360 * 50, Qt.vector3d(0.5, 1.0, 0.0));
					return m;
				}

				Time {
					id: time
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
								vertName: root.useQtTransform?
											  "coordinate_systems_qt3d_transform":
											  "coordinate_systems"
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
									name: "model"
									value: transform.matrix // vs Qt3D Transform
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

			components: [geometry, transform, material]
		}
	}
}

