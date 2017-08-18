import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

import VirtualKey 1.0

import "Components"

Scene0 {
	/*
		To enable keyboard, we need focus and enable input aspect
		making this scene as InputSettings.eventSource
		See example: qt3d/controls/main.qml
		Source:
			qt3d/src/quick3d/imports/scene3d/scene3ditem.cpp:190
				// Set ourselves up as a source of input events for the input aspect
				Qt3DInput::QInputSettings *inputSettings = m_entity->findChild<Qt3DInput::QInputSettings *>();
				if (inputSettings) {
					inputSettings->setEventSource(this);
				} else {
					qWarning() << "No Input Settings found, keyboard and mouse events won't be handled";
				}

	*/

	id: scene
	focus: true
	aspects: ["input"]

	children: VirtualKeys {
		target: scene
		targetHandler: keyboardHandler
		gameButtonsEnabled: false
		color: "transparent"
	}

	Entity {
		/*
			Use KeyboardHandler to handle keyboard input events
			See example: qt3d/wave/main.qml
		*/

		id: root

		property real mixValue: .5

		RenderSettings0 {}

		InputSettings {} // THE InputSettings

		KeyboardDevice {
			id: keyboardDevice
		}

		KeyboardHandler {
			id: keyboardHandler
			focus: true
			onUpPressed: root.mixValue = Geo.mix(root.mixValue, 1., .1)
			onDownPressed: root.mixValue = Geo.mix(root.mixValue, 0., .1)
			sourceDevice: keyboardDevice
		}

		Entity {
			id: plane

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					boundingVolumePositionAttribute: position

					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 0
						byteStride: 8 * 4
						name: "position"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 3 * 4
						byteStride: 8 * 4
						name: "color"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 4
						byteOffset: 6 * 4
						byteStride: 8 * 4
						name: "texCoord"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: new Uint16Array([
								0, 1, 3,  // First Triangle
								1, 2, 3,  // Second Triangle
							])
						}
					}
				}

				Buffer {
					id: vertexBuffer
					type: Buffer.VertexBuffer
					data: new Float32Array([
						// Positions	  // Colors		// Texture Coords
						 0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // Top Right
						 0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // Bottom Right
						-0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // Bottom Left
						-0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0, // Top Left
					])
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: AutoShaderProgram {
								vertName: "textures_combined"
								fragName: "textures-exercise4"
							}
						}
					}
				}

				parameters: [
					Parameter {
						name: "ourTexture1"
						value: Texture2D { // #TRYIT: change filtering mode
							generateMipMaps: true
							minificationFilter: Texture.Linear
							magnificationFilter: Texture.Linear
							wrapMode { // #TRYIT: change wrap mode
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
						value: Texture2D { // #TRYIT: change filtering mode
							generateMipMaps: true
							minificationFilter: Texture.Linear
							magnificationFilter: Texture.Linear
							wrapMode { // #TRYIT: change wrap mode
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
						name: "mixValue"
						value: root.mixValue
					}
				]
			}

			components: [geometry, material]
		}
	}
}
