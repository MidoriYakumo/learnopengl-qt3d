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

			property Texture2D framebuffer: Texture2D {
				id: framebuffer
				width: scene.width
				height: scene.height
				format: Texture.RGBA32F


				onNodeDestroyed: console.log("Texture2D onNodeDestroyed")
			}


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
						}


						RenderTargetSelector {
							// W/Adreno-ES20(17579): <validate_render_targets:454>: GL_INVALID_OPERATION
							ClearBuffers {
								buffers: ClearBuffers.ColorDepthBuffer
								clearColor: "transparent"
								RenderPassFilter {
									matchAny: FilterKey { name: "pass"; value: "material" }
								}
							}
							target: RenderTarget {
								attachments: [
									RenderTargetOutput {
										attachmentPoint : RenderTargetOutput.Color0
										texture : framebuffer
										onNodeDestroyed: console.log("RenderTargetOutput onNodeDestroyed")
									}
								]
							}
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
			id: plane
			components: [planeMesh, planeTransform, planeMaterial]

			PlaneMesh{ id: planeMesh }

			Transform {
				id: planeTransform
				rotation: fromAxisAndAngle(Qt.vector3d(1., 0., 0.), 90)
			}

			PhongMaterial {
				id: planeMaterialx
				diffuse: "white"
			}

			Material {
				id: planeMaterial
				effect: Effect {
					techniques: Technique {
						filterKeys: FilterKey {
							name: "renderingStyle"
							value: "forward"
						}
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
									vertName: "passthrough"
									fragName: "mosaic"
								}
						}
					}

					parameters: Parameter {
							name: "texture"
							value: framebuffer
					}

				}
			}
		}

		Entity {
			id: cube1
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
