import QtQuick 2.7
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
		enableGameButtons: false
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
			mouseSensitivity: 0.5 / Units.dp
		}

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			sourceDevice: keyboardDevice
			focus: true

			onSpacePressed: {
				root.useQtMaterial = !root.useQtMaterial;
				console.log("useQtMaterial:", root.useQtMaterial);
			}
		}


		property bool useQtMaterial: false

		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor: "white"

		QtObject {
			id: light

			property vector3d position: "1.2, 1.0, 2.0"

			property vector3d ambient: ".2, .2, .2"
			property vector3d diffuse: ".5, .5, .5"
			property vector3d specular: "1., 1., 1."
		}

		CuboidMesh {
			id: mesh
		}

		Entity {
			id: object

			Transform {
				id: objectTransform
			}

			Material {
				id: ourMaterial
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
								vertName: "basic_lighting"
								fragName: "materials"
							}
							parameters: [
								Parameter {
									name: "viewPos"
									value: root.viewPos
								},
								Parameter {
									name: "material.ambient"
									value: root.material.ambient
								},
								Parameter {
									name: "material.diffuse"
									value: root.material.diffuse
								},
								Parameter {
									name: "material.specular"
									value: root.material.specular
								},
								Parameter {
									name: "material.shininess"
									value: root.material.shininess
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
						}
					}
				}
			}

			PhongMaterial {
				/*
					Phong material in Qt3D.Extras, Qt PointLight is required to work with
					The model is different with learnopengl.com
					Src: Src/qt3d/src/quick3d/imports/extras/defaults/qml/PhongMaterial.qml
				*/

				id: qtMaterial
				ambient: Qt.rgba(root.material.ambient.x, root.material.ambient.y,
					root.material.ambient.z, 1.)
				diffuse: Qt.rgba(root.material.diffuse.x, root.material.diffuse.y,
					root.material.diffuse.z, 1.)
				specular: Qt.rgba(root.material.specular.x, root.material.specular.y,
					root.material.specular.z, 1.)
				shininess: root.material.shininess
			}

			components: [mesh, objectTransform, root.useQtMaterial?qtMaterial:ourMaterial]
		}

		Entity {
			id: renderLamp

			PointLight {
				/*
					Point light from Qt3D.Render, one of the lighting types supported internally in Qt3D
					Can be assembled with other nodes into one entity
					Src: Src/qt3d/src/render/lights/qpointlight.h
				*/

				id: qtLamp
				color: root.lightColor
				intensity: 1
			}

			Transform {
				id: lampTransform
				translation: light.position
				scale: .2
			}

			Material {
				id: lampMaterial
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							shaderProgram: ShaderProgram0 {
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

			components: [mesh, qtLamp, lampTransform, lampMaterial]
		}
	}
}
