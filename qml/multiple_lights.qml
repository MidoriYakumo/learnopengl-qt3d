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
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space},
			]
		}
	}

	Entity {
		id: root

		RenderInputSettings0 {
			id: renderInputSettings

			mouseSensitivity: .5 / Units.dp
		}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			sourceDevice: keyboardDevice
			focus: true

			onSpacePressed: {
				root.useQtLight = !root.useQtLight;
				console.log("useQtLight:", root.useQtLight);
			}
		}

		property bool useQtLight: false

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
		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor: "white"
		property Entity material: Entity {
			property Texture2D diffuseMap: Texture2D {
				TextureImage {
					source: Resources.texture("container2.png")
				}
			}

			property Texture2D specularMap: Texture2D {
				TextureImage {
					source: Resources.texture("container2_specular.png")
				}
			}

			property real shininess: 32.
		}

		property var lights: {
			"dirLight": {
				"direction": Qt.vector3d(-0.2, -1.0, -0.3),
				"ambient": Qt.vector3d(0.05, 0.05, 0.05),
				"diffuse": Qt.vector3d(0.4, 0.4, 0.4),
				"specular": Qt.vector3d(0.5, 0.5, 0.5),
			},
			"pointLights": [
				{
					"position": Qt.vector3d(0.7,  0.2,  2.0),
					"ambient": Qt.vector3d(0.05, 0.05 ,0.05),
					"diffuse": Qt.vector3d(0.8, 0.8, 0.8),
					"specular": Qt.vector3d(1.0, 1.0, 1.0),
					"constant": 1.,
					"linear": .09,
					"quadratic": .032,
				},
				{
					"position": Qt.vector3d(2.3, -3.3, -4.0),
					"ambient": Qt.vector3d(0.05, 0.05 ,0.05),
					"diffuse": Qt.vector3d(0.8, 0.8, 0.8),
					"specular": Qt.vector3d(1.0, 1.0, 1.0),
					"constant": 1.,
					"linear": .09,
					"quadratic": .032,
				},
				{
					"position": Qt.vector3d(-4.0,  2.0, -12.0),
					"ambient": Qt.vector3d(0.05, 0.05 ,0.05),
					"diffuse": Qt.vector3d(0.8, 0.8, 0.8),
					"specular": Qt.vector3d(1.0, 1.0, 1.0),
					"constant": 1.,
					"linear": .09,
					"quadratic": .032,
				},
				{
					"position": Qt.vector3d(-0.0,  0.0, -3.0),
					"ambient": Qt.vector3d(0.05, 0.05 ,0.05),
					"diffuse": Qt.vector3d(0.8, 0.8, 0.8),
					"specular": Qt.vector3d(1.0, 1.0, 1.0),
					"constant": 1.,
					"linear": .09,
					"quadratic": .032,
				},
			],
//			"spotLight": { }
		}

		CuboidMesh {
			id: mesh
		}

		Material {
			id: ourMaterial
			effect: Effect {
				techniques: AutoTechnique {
					renderPasses: RenderPass {
						id: ourRenderpass

						Component {
							id: parameterComponent

							Parameter {}
						}

						Time {
							id: time
						}

						shaderProgram: AutoShaderProgram {
							vertName: "lighting_maps"
							fragName: "multiple_lights"
						}
						parameters: [
							Parameter {
								name: "viewPos"
								value: root.viewPos
							},
							Parameter {
								name: "material.diffuse"
								value: root.material.diffuseMap
							},
							Parameter {
								name: "material.specular"
								value: root.material.specularMap
							},
							Parameter {
								name: "material.shininess"
								value: root.material.shininess
							},
							Parameter {
								name: "dirLight.direction"
								value: root.lights.dirLight.direction
							},
							Parameter {
								name: "dirLight.ambient"
								value: root.lights.dirLight.ambient
							},
							Parameter {
								name: "dirLight.diffuse"
								value: root.lights.dirLight.diffuse
							},
							Parameter {
								name: "dirLight.specular"
								value: root.lights.dirLight.specular
							},
							Parameter {
								id: pointLightCount

								name: "pointLightCount"
								value: intValue// root.lights.pointLights.length

								property int intValue: time.value % root.lights.pointLights.length
							}
						]

						Component.onCompleted: {
							var pList = [].slice.apply(parameters);
							root.lights.pointLights.forEach(function (light, i){
								for (var p in light) {
									pList.push(parameterComponent.createObject(ourRenderpass, {
										name: "pointLights[%1].%2".arg(i).arg(p),
										value: light[p]
									}))
								}
							})
							pList.forEach(function (p){
								console.log(p.name, '=', p.value);
							})
							parameters = pList;
						}
					}
				}
			}
		}

		DiffuseSpecularMapMaterial {
			id: qtMaterial
			ambient: Qt.rgba(root.lights.dirLight.ambient.x,
				root.lights.dirLight.ambient.y,
				root.lights.dirLight.ambient.z, 1.) // ...
			diffuse: root.material.diffuseMap   // Qt5.9 ???
			specular: root.material.specularMap // Qt5.9 ???
			shininess: root.material.shininess
		}

		NodeInstantiator {
			model: root.cubePositions
			delegate: Entity {
				property Transform transform: Transform {
					translation: modelData
					rotation: fromAxisAndAngle(Qt.vector3d(0.5, 1.0, 0.0), 20 * index)
				}
				components: [mesh, root.useQtLight?qtMaterial:ourMaterial, transform]
			}
		}

		Entity {
			id: sun

			components: DirectionalLight {
				color: "white"
				worldDirection: root.lights.dirLight.direction
			}
		}

		Material {
			id: lightMaterial
			effect: Effect {
				techniques: AutoTechnique {
					renderPasses: RenderPass {
						shaderProgram: AutoShaderProgram {
							vertName: "basic_lighting"
							fragName: "shaders-uniform"
						}
						parameters: [
							Parameter {
								name: "ourColor"
								value: root.lightColor
							}
						]
					}
				}
			}
		}

		NodeInstantiator {
			model: root.lights.pointLights.slice(0, pointLightCount.intValue)
			delegate: Entity {
				property PointLight light: PointLight {
					color: "white"
					intensity: 1.
					constantAttenuation: modelData.constant
					linearAttenuation: modelData.linear
					quadraticAttenuation: modelData.quadratic
				}
				property Transform transform: Transform {
					translation: modelData.position
					scale: .2
				}
				components: [mesh, light, transform, lightMaterial]
			}
		}
	}
}
