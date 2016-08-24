import QtQuick 2.7

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			TriangleGeometry0 {
				id: geometry
			}

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram0 {
								vertName: "shaders-exercise1"
								fragName: "shaders-uniform"
							}
						}
					}
					parameters: Parameter {
						id: ourColor
						name: "ourColor"
						value: Qt.rgba(0, greenValue, 0, 1)

						property real greenValue: (Math.sin(time.value) / 2.) + 0.5
					}

				}
			}

			components: [geometry, material]
		}

		Item {
			id: time
			property real value

			NumberAnimation {
				target: time
				property: "value"
				duration: Math.PI * 2000
				from: 0
				to: Math.PI * 2

				loops: Animation.Infinite
				running: true
			}
		}
	}
}
