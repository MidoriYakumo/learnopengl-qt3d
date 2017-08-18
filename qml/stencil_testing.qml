import QtQuick 2.9

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: VirtualKeys {
		target: scene
		gameButtonsEnabled: false
		color: "transparent"
	}

	Entity {
		id: root

		RenderSettings {
			activeFrameGraph: RenderSurfaceSelector {
				RenderPassFilter {
					matchAny: FilterKey {
						name: "pass"
						value: "material"
					}

					RenderStateSet {
						renderStates: [
							DepthTest {
								depthFunction: DepthTest.Less
							},
							StencilOperation {
								front.allTestsPassOperation: StencilOperationArguments.Replace
								back.allTestsPassOperation: StencilOperationArguments.Replace
							}
						]
					}

					ClearBuffers {
						buffers: ClearBuffers.ColorDepthStencilBuffer
						clearColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)

						CameraSelector {
							camera: ourCamera
						}
					}
				}

				RenderPassFilter {
					matchAny: FilterKey {
						name: "pass"
						value: "outline"
					}

					ClearBuffers {
						buffers: ClearBuffers.ColorDepthBuffer

						RenderStateSet {
							renderStates: [
								DepthTest {
									depthFunction: DepthTest.Always
								},
								StencilTest {
									front {
										stencilFunction: StencilTestArguments.NotEqual
										referenceValue: 1; comparisonMask: 0xff
									}
									back {
										stencilFunction: StencilTestArguments.NotEqual
										referenceValue: 1; comparisonMask: 0xff
									}
								}
							]
						}

						CameraSelector {
							camera: ourCamera
						}
					}
				}
			}
		}

		InputSettings {}

		OurCamera {
			id: ourCamera
		}

		OurCameraController {
			id: cameraController

			camera: ourCamera
			mouseSensitivity: .5 / Units.dp
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

		QtObject {
			id: light

			property vector3d position: "1.2, 1.0, 2.0"

			property vector3d ambient: "0.2, 0.2, 0.2"
			property vector3d diffuse: "0.5, 0.5, 0.5"
			property vector3d specular: "1.0, 1.0, 1.0"
		}

		CuboidMesh {
			id: mesh
		}

		Material {
			id: material
			effect: Effect {
				techniques: AutoTechnique {
					renderPasses: [
						RenderPass {
							filterKeys: FilterKey {
								name: "pass"
								value: "material"
							}
							shaderProgram: AutoShaderProgram {
								vertName: "lighting_maps"
								fragName: "lighting_maps_diffuse"
							}
							parameters: [
								Parameter {
									name: "viewPos"
									value: ourCamera.position
								},
								Parameter {
									name: "material.diffuse"
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
									name: "material.specular"
									value: Qt.vector3d(0.2, 0.2, 0.2)
								},
								Parameter {
									name: "material.shininess"
									value: 32.
								},
								Parameter {
									name: "light.position"
									value: light.position
								},
								Parameter {
									name: "light.ambient"
									value: light.ambient
								},
								Parameter {
									name: "light.diffuse"
									value: light.diffuse
								},
								Parameter {
									name: "light.specular"
									value: light.specular
								}
							]
						},
						RenderPass {
							filterKeys: FilterKey {
								name: "pass"
								value: "outline"
							}
							renderStates: [
								CullFace {
									mode: CullFace.NoCulling
								}
							]
							shaderProgram: AutoShaderProgram {
								vertName: "outline"
								fragName: "outline"
							}
							parameters: Parameter {
								name: "outlineRatio"
								value: 0.05
							}
						}
					]
				}
			}
		}

		NodeInstantiator {
			model: root.cubePositions
			delegate: Entity {
				property Transform transform: Transform {
					translation: modelData
					rotation: fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), 20 * index)
				}

				components: [mesh, transform, material]
			}
		}
	}
}
