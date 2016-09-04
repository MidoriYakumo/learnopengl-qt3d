import QtQuick 2.7 as QQ2 // (QtQuick/Qt3d).Transform may be ambiguous

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

				focus: true
				onSpacePressed: {
					root.enableDepthTest = !root.enableDepthTest
					if (root.enableDepthTest) {
						renderStateSet.renderStates = [root.storeDepthTest]
					} else {
						root.storeDepthTest = renderStateSet.renderStates[0]
						renderStateSet.renderStates = []
					}

					console.log("enableDepthTest:", root.enableDepthTest)
				}
				onReturnPressed: {
					root.useQtTransform = !root.useQtTransform
					console.log("useQtTransform:", root.useQtTransform)
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

					matrix: (function(){ // modelMatrix
						var m = Qt.matrix4x4()
						m.rotate(time.value % 360 * 50, Qt.vector3d(.5, 1, 0))
						return m
					})()

					Time {
						id: time
					}
				}

				Material {
					id: material
					effect: Effect {
						techniques: Technique {
							renderPasses: RenderPass {
								shaderProgram: ShaderProgram0 {
									vertName: root.useQtTransform?"coordinate_systems_qt3d_transform":"coordinate_systems"
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
										value: (function(){
											var m = Qt.matrix4x4()
											m.translate(0, 0, -3)
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

				components: [geometry, transform, material]
			}
		}
	}

	VirtualKeys {
		target: scene
		showPad: false
		keys: [
			{text:"Space", key:Qt.Key_Space},
			{text:"Return", key:Qt.Key_Return}
		]
	}
}

