import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.XmlListModel 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import VirtualKey 1.0

import "Components"

Scene2 {
	id: scene
	children: [
		Button {
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			anchors.rightMargin: Units.dp * 16
			anchors.bottomMargin: Units.dp * 12

			property bool enabled: progressBar.value === 1

			text: "Materials"
			contentItem.visible: enabled

			XmlListModel {
				id: materialDataModel
				source: "http://devernay.free.fr/cours/opengl/materials.html"
				query: "/html/body/table/tbody/tr"

				XmlRole { name: "td"; query: "td/string()" }
			}

			BusyIndicator {
				id: busyIndicator
				anchors.fill: parent
				anchors.margins: parent.padding / 2

				visible: progressBar.value === 0
			}

			ProgressBar {
				id: progressBar
				anchors.fill: parent
				anchors.margins: parent.padding / 2

				visible: value > 0 && value < 1 &&
						materialDataModel.status == XmlListModel.Loading
				value: materialDataModel.progress
			}

			onClicked: {
				if (!enabled)
					return;

				console.log(materialDataModel.count)
			}
		},
		VirtualKeys {
			target: scene
			enableGameButtons: false
			color: "transparent"
		}
	]

	Entity {
		id: root

		RenderInputSettings0 {
			id: renderInputSettings

			mouseSensitivity: 0.5 / Units.dp
		}

		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor

		Entity {
			id: material

			property vector3d ambient: "1.0, 0.5, 0.31"
			property vector3d diffuse: "1.0, 0.5, 0.31"
			property vector3d specular: "0.5, 0.5, 0.5"
			property real shininess: 32.0
		}

		Entity {
			id: light

			property vector3d position: "1.2, 1.0, 2.0"

			property vector3d ambient: diffuse.times(0.2)
			property vector3d diffuse: Qt.vector3d(root.lightColor.r, root.lightColor.g, root.lightColor.b).times(0.5)
			property vector3d specular: "1.0, 1.0, 1.0"
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
				id: objectMaterial
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
									value: material.ambient
								},
								Parameter {
									name: "material.diffuse"
									value: material.diffuse
								},
								Parameter {
									name: "material.specular"
									value: material.specular
								},
								Parameter {
									name: "material.shininess"
									value: material.shininess
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

			components: [mesh, objectTransform, objectMaterial]
		}

		Entity {
			id: lamp

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
									value: light.ambient.times(.3).plus(
										light.diffuse.times(.4)).plus(
										light.specular.times(.3))
								}
							]
						}
					}
				}
			}

			components: [mesh, lampTransform, lampMaterial]
		}

		SequentialAnimation {
			running: true
			loops: Animation.Infinite
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				from: "red"
				to: "green"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				from: "green"
				to: "blue"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				from: "blue"
				to: "red"
			}
		}
	}
}
