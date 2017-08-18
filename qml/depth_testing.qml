import Qt3D.Core 2.0
import Qt3D.Render 2.0
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

		property real fov: renderInputSettings.camera.fieldOfView
		property real nearZ: renderInputSettings.camera.nearPlane
		property real farZ: renderInputSettings.camera.farPlane

		SphereMesh {
			id: mesh
		}

		Material {
			id: material
			effect: Effect {
				techniques: AutoTechnique {
					renderPasses: RenderPass {
						shaderProgram: AutoShaderProgram {
							fragName: "depth_visualize"
						}
						parameters: [
							Parameter {
								name: "nearZ"
								value: root.nearZ
							},
							Parameter {
								name: "farZ"
								value: root.farZ
							}
						]
					}
				}
			}
		}

		NodeInstantiator {
			model: 1000
			delegate: Entity {
				property Transform transform: Transform {
					property real z: Math.random() * -root.farZ
					translation: Qt.vector3d(
						(Math.random()-.5) * z * Math.tan(root.fov / 2.) * 2.,
						(Math.random()-.5) * z * Math.tan(root.fov / 2.) * 2.,
						z
					)
					scale: Math.random() * .1 * z + .5
				}

				components: [mesh, transform, material]
			}
		}
	}
}
