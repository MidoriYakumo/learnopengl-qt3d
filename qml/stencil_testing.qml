import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		Camera0 {
			id: camera
		}

		RenderSettings {
			id: renderSettings
			activeFrameGraph: Viewport {
				RenderSurfaceSelector {
					CameraSelector {
						camera: camera

						ClearBuffers {
							buffers: ClearBuffers.ColorDepthStencilBuffer
							clearColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
							RenderPassFilter {
								matchAny: FilterKey { name: "pass"; value: "material" }
							}
//							RenderStateSet {
//								renderStates: [
//									CullFace { mode: CullFace.Back },
//									StencilTest {
//										front {
//											stencilFunction: StencilTestArguments.Always
//											referenceValue: 2; comparisonMask: 0xff
//										}
//										back {
//											stencilFunction: StencilTestArguments.Always
//											referenceValue: 2; comparisonMask: 0xff
//										}
//									}
//								]
//							}
						}

						ClearBuffers {
							RenderPassFilter {
								matchAny: FilterKey { name: "pass"; value: "stencilFill"; }
							}
							RenderStateSet {
								renderStates: [
									CullFace { mode: CullFace.Back },
									StencilOperation {
										front.allTestsPassOperation: StencilOperationArguments.Replace
										back.allTestsPassOperation: StencilOperationArguments.Replace
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
						}

					}
				}
			}
		}

		Inputs0 {
			camera: camera
		}

		Entity {
			id: chest
			components: [cube, cubeMaterial, cubeTransform]

			CappingDiffuseSpecularEmissionMapMaterial {
				id: cubeMaterial

				ambient: Qt.rgba(.4, .4, .4, 1.)
				diffuseName: "container2.png"
				specularName: "container2_specular.png"
				emissionName: "matrix.jpg"
			}

			CuboidMesh {
				id: cube
			}

			Transform {
				id: cubeTransform
				rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .8), 60)
			}
		}
	}
}
