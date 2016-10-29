import QtQuick 2.7 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import "Components"
import "VirtualKey"

QQ2.Item {
	height: 600
	width: 800

	Scene2 {
		id: scene
		anchors.fill: parent

		Entity {
			id: root

			RenderSettings1 {}

			InputSettings {}

			KeyboardDevice {
				id: keyboardDevice
			}

			property var keys: {
				"up":false, "down":false, "left":false, "right": false
			}

			KeyboardHandler {
				id: keyboardHandler
				sourceDevice: keyboardDevice
				focus: true

				onPressed: {
					switch (event.key) {
					case Qt.key_W:
					case 'W'.charCodeAt(0):
					case Qt.Key_Up:
						root.keys.up = true
						break
					case Qt.key_S:
					case 'S'.charCodeAt(0):
					case Qt.Key_Down:
						root.keys.down = true
						break
					case Qt.key_A:
					case 'A'.charCodeAt(0):
					case Qt.Key_Left:
						root.keys.left = true
						break
					case Qt.key_D:
					case 'D'.charCodeAt(0):
					case Qt.Key_Right:
						root.keys.right = true
						break
					}
				}

				onReleased: {
					switch (event.key) {
					case Qt.key_W:
					case 'W'.charCodeAt(0):
					case Qt.Key_Up:
						root.keys.up = false
						break
					case Qt.key_S:
					case 'S'.charCodeAt(0):
					case Qt.Key_Down:
						root.keys.down = false
						break
					case Qt.key_A:
					case 'A'.charCodeAt(0):
					case Qt.Key_Left:
						root.keys.left = false
						break
					case Qt.key_D:
					case 'D'.charCodeAt(0):
					case Qt.Key_Right:
						root.keys.right = false
						break
					}
				}
			}

			MouseDevice {
				/*
					MouseDevice wraps mouse input devices
					If you are using Qt3D logic to bind input event with object data(position, angle ...)
					sensitivity is multiplied automatically and internally
				*/

				id: mouseDevice
				sensitivity: 0.5 / Units.dp
			}

			MouseHandler {
				/*
					MouseHandler, the Qt3D version of MouseArea
					the default event variable is mouse and wheel
				*/

				id: mouseHandler
				sourceDevice: mouseDevice

				property int posX
				property int posY

				onPressAndHold: { // onPressd not works, weird!
					posX = mouse.x
					posY = mouse.y
				}

				onPositionChanged: {
					var sensitivity = mouseDevice.sensitivity
					if (mouse.modifiers & Qt.ShiftModifier)
						sensitivity *= .1
					var yaw = ourCamera.yaw + (mouse.x - posX) * sensitivity
					var pitch = ourCamera.pitch + (mouse.y - posY) * sensitivity

					pitch = (pitch>89.)?89.:(pitch<-89.)?-89.:pitch

					ourCamera.yaw = yaw
					ourCamera.pitch = pitch

					posX = mouse.x
					posY = mouse.y
				}

				onWheel: {
					var d = wheel.angleDelta.y * 1e-3
					if (d>0)
						camera.fieldOfView = Utils.mix(camera.fieldOfView, 1., d)
					else
						camera.fieldOfView = Utils.mix(camera.fieldOfView, 45., -d)
				}
			}

			FrameSwap {
				property real cameraSpeed: 5.
				onTriggered: {
					if (root.keys.up)
						camera.position = camera.position.plus(
							camera.frontVector.times(cameraSpeed * dt))
					if (root.keys.down)
						camera.position = camera.position.minus(
							camera.frontVector.times(cameraSpeed * dt))
					if (root.keys.right)
						camera.position = camera.position.plus(
							camera.rightVector.times(cameraSpeed * dt))
					if (root.keys.left)
						camera.position = camera.position.minus(
							camera.rightVector.times(cameraSpeed * dt))
				}
			}

			Entity {
				id: ourCamera

				property real yaw: 0
				property real pitch: 0
				property real fieldOfView: 45

				property vector3d position: "0,0,3"
				property vector3d viewCenter: position.plus(frontVector)
				property vector3d upVector: "0,1,0"
				property vector3d frontVector: Qt.vector3d(
					Math.cos(pitch * Math.PI / 180.) * Math.sin(yaw * Math.PI / 180.),
					-Math.sin(pitch * Math.PI / 180.),
					-Math.cos(pitch * Math.PI / 180.) * Math.cos(yaw * Math.PI / 180.)
				)
				property vector3d rightVector: frontVector.crossProduct(upVector).normalized()

				property matrix4x4 viewMatrix: {
					var m = Qt.matrix4x4()
					m.lookAt(position, viewCenter, upVector)
					return m
				}
				property matrix4x4 projectionMatrix: {
					var aspect = scene.width / scene.height
					var zNear = .1
					var zFar = 100.
					var h = Math.tan(fieldOfView * Math.PI / 360) * zNear
					var w = h * aspect

					var m = Qt.matrix4x4()
					m.m11 = zNear / w
					m.m22 = zNear / h
					m.m33 = - (zNear + zFar) / (zFar - zNear)
					m.m43 = -1
					m.m34 = -2 * zNear * zFar / (zFar - zNear)
					return m
				}
			}

			Camera {
				id: qtCamera

				projectionType: CameraLens.PerspectiveProjection
				fieldOfView: 45  // Projection
				aspectRatio: scene.width/scene.height
				nearPlane : 0.1
				farPlane : 100.0
				position: Qt.vector3d(0,0,3) // View
				viewCenter: Qt.vector3d(0,0,0)
				upVector: Qt.vector3d(0,1,0)
			}

			property bool useQtCameraAndMesh: false

			property Entity camera: useQtCameraAndMesh?qtCamera:ourCamera

			property color objectColor: "coral"
			property color lightColor: "white"

			TextureCubeGeometry0 {
				id: geometry
			}

			CuboidMesh {
				id: mesh
			}

			Entity {
				id: object
				components: [root.useQtCameraAndMesh?mesh:geometry,
					objectTransform, objectMaterial
				]

				Transform {
					id: objectTransform
				}

				Material {
					id: objectMaterial
					effect: Effect {
						techniques: Technique {
							renderPasses: RenderPass {
								shaderProgram: ShaderProgram0 {
									vertName: "coordinate_systems_qt3d_transform"
									fragName: "lighting"
								}
								parameters: [
									Parameter {
										name: "view"
										value: ourCamera.viewMatrix
									},
									Parameter {
										name: "projection"
										value: ourCamera.projectionMatrix
									},
									Parameter {
										name: "objectColor"
										value: Qt.vector3d(
											root.objectColor.r,
											root.objectColor.g,
											root.objectColor.b
										)
									},
									Parameter {
										name: "lightColor"
										value: Qt.vector3d(
											root.lightColor.r,
											root.lightColor.g,
											root.lightColor.b
										)
									}
								]
							}
						}
					}
				}
			}

			Entity {
				id: lamp
				components: [root.useQtCameraAndMesh?mesh:geometry,
					lampTransform, lampMaterial
				]

				Transform {
					id: lampTransform
					translation: Qt.vector3d(1.2, 1.0, 2.0)
					scale: .2 // Use scale to decrease lamp size
				}

				Material {
					id: lampMaterial
					effect: Effect {
						techniques: Technique {
							renderPasses: RenderPass {
								shaderProgram: ShaderProgram0 {
									vertName: "coordinate_systems_qt3d_transform"
									fragName: "shaders-uniform"
								}
								parameters: [
									Parameter {
										name: "view"
										value: ourCamera.viewMatrix
									},
									Parameter {
										name: "projection"
										value: ourCamera.projectionMatrix
									},
									Parameter {
										name: "ourColor"
										value: root.lightColor
									}
								]
							}
						}
					}
				}
			}
		}
	}

	VirtualKeys {
		target: scene
		enableGameButtons: false
		color: "transparent"
		centerItem: RowKeys {
			keys: [
				{text:"Space", key:Qt.Key_Space}
			]
		}
	}
}

