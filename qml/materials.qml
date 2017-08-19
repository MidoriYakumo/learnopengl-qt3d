import QtQuick 2.9
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
		ComboBox {
			id: materialSelector
			wheelEnabled: true
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.topMargin: 8
			anchors.leftMargin: 8
			focusPolicy: Qt.NoFocus
			textRole: "name"
			displayText: currentIndex>=0?
					currentText.setCharAt(0, currentText[0].toUpperCase()):
					"Materials"

			property real defaultLeftPadding

			model: XmlListModel {
				source: "http://devernay.free.fr/cours/opengl/materials.html"
				namespaceDeclarations: 'declare default element namespace "http://www.w3.org/1999/xhtml";'
				query: "/html/body/table//tr[position()>1]"

				XmlRole { name: "name"; query: "td[1]/string()"; isKey: true }
				XmlRole { name: "ambr"; query: "td[2]/number()" }
				XmlRole { name: "ambg"; query: "td[3]/number()" }
				XmlRole { name: "ambb"; query: "td[4]/number()" }
				XmlRole { name: "difr"; query: "td[5]/number()" }
				XmlRole { name: "difg"; query: "td[6]/number()" }
				XmlRole { name: "difb"; query: "td[7]/number()" }
				XmlRole { name: "specr"; query: "td[8]/number()" }
				XmlRole { name: "specg"; query: "td[9]/number()" }
				XmlRole { name: "specb"; query: "td[10]/number()" }
				XmlRole { name: "shininess"; query: "td[11]/number()" }

				onProgressChanged: {
					if (progress >= 1) {
						hideBusy.start();
					}
				}
			}

			delegate: MenuItem {
				text: name.setCharAt(0, name[0].toUpperCase())
				leftPadding: rightPadding + thumbSize

				property real thumbSize: height - topPadding * 2

				Item {
					x: parent.rightPadding / 2
					y: parent.topPadding
					height: parent.thumbSize
					width: parent.thumbSize

					property real dotSize: parent.thumbSize/2
					property real sparkSize: 1./shininess

					Rectangle {
						x: 0
						y: 0
						width: parent.dotSize
						height: parent.dotSize
						radius: parent.sparkSize
						color: Qt.rgba(ambr, ambg, ambb, 1.)
					}

					Rectangle {
						x: parent.dotSize
						y: 0
						width: parent.dotSize
						height: parent.dotSize
						radius: parent.sparkSize
						color: Qt.rgba(difr, difg, difb, 1.)
					}

					Rectangle {
						x: 0
						y: parent.dotSize
						width: parent.dotSize
						height: parent.dotSize
						radius: parent.sparkSize
						color: Qt.rgba(specr, specg, specb, 1.)
					}

					Rectangle {
						x: parent.dotSize
						y: parent.dotSize
						width: parent.dotSize
						height: parent.dotSize
						radius: parent.sparkSize
						color: Qt.rgba(ambr, ambg, ambb, 1.)
					}
				}
			}

			BusyIndicator {
				id: busyIndicator
				width: height
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.margins: 4
			}

			ParallelAnimation {
				id: hideBusy

				NumberAnimation {
					target: materialSelector
					property: "leftPadding"
					duration: 400
					to: materialSelector.defaultLeftPadding
					easing.type: Easing.InOutQuad
				}

				NumberAnimation {
					target: busyIndicator
					property: "opacity"
					duration: 400
					to: 0
				}
			}


			onCurrentIndexChanged: {
				var m = model.get(currentIndex);
				root.material.ambient = Qt.vector3d(m.ambr, m.ambg, m.ambb);
				root.material.diffuse = Qt.vector3d(m.difr, m.difg, m.difb);
				root.material.specular = Qt.vector3d(m.specr, m.specg, m.specb);
				root.material.shininess = m.shininess * 128;
				light.ambient = Qt.vector3d(1,1,1);
				light.diffuse = Qt.vector3d(1,1,1);
			}

			Component.onCompleted: {
				defaultLeftPadding = leftPadding;
				var dw = busyIndicator.width - busyIndicator.padding * 2;
				leftPadding += dw;
				width += dw;
			}
		},
		VirtualKeys {
			target: scene
			gameButtonsEnabled: false
			color: "transparent"
			centerItem: RowKeys {
				keys: [
					{text:"Space", key:Qt.Key_Space},
				]
			}
		}
	]

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
				root.useQtMaterial = !root.useQtMaterial;
				console.log("useQtMaterial:", root.useQtMaterial);
			}
		}

		property bool useQtMaterial: false

		property vector3d viewPos: renderInputSettings.camera.position
		property color lightColor
		property var material: QtObject {
			property vector3d ambient: "1.0, 0.5, 0.31"
			property vector3d diffuse: "1.0, 0.5, 0.31"
			property vector3d specular: "0.5, 0.5, 0.5"
			property real shininess: 32.
		}

		QtObject {
			id: light

			property vector3d position: "1.2, 1.0, 2.0"

			property vector3d ambient: diffuse.times(.2)
			property vector3d diffuse: Qt.vector3d(root.lightColor.r, root.lightColor.g, root.lightColor.b).times(.5)
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
				id: ourMaterial
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							shaderProgram: AutoShaderProgram {
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
				intensity: 1.
			}

			Transform {
				id: lampTransform
				translation: light.position
				scale: .2
			}

			Material {
				id: lampMaterial
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

			components: [mesh, qtLamp, lampTransform, lampMaterial]
		}

		SequentialAnimation {
			running: true
			loops: Animation.Infinite
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "green"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "grey"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "blue"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "white"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "red"
			}
			ColorAnimation {
				target: root
				property: "lightColor"
				duration: 2000
				to: "black"
			}
		}
	}
}
