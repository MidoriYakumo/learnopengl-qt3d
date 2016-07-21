import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings1 {
			id: settings
		}

		Entity{
			id: planet
			components: SceneLoader {
//			components: Mesh {
				source: Resources.model("planet.obj")
			}
		}

		Entity{
			id: rock
			property int instanceCount: 10000
			components: [
				Mesh {
					source: Resources.model("rock.obj")
					instanceCount: rock.instanceCount
				},
				Material {
					effect: Effect {
						techniques: Technique {
							filterKeys: [ FilterKey { name: "renderingStyle"; value: "forward" } ]
							renderPasses: RenderPass {
								shaderProgram: ShaderProgram0 {
									vertName: "instancing"
									fragName: "passthrough"
								}
							}
						}
					}
					parameters: [
						Parameter { name: "instanceCount"; value: rock.instanceCount },
						Parameter {
							name: "texture"
							value: Texture2D {
								minificationFilter: Texture.LinearMipMapLinear
								magnificationFilter: Texture.Linear
								wrapMode {
									x: WrapMode.Repeat
									y: WrapMode.Repeat
								}
								generateMipMaps: true
								maximumAnisotropy: 16.0
								TextureImage {
									source: Resources.model("Rock-Texture-Surface.jpg")
								}
							}
						}
					]
				}
			]
		}

		QQ2.Component.onCompleted: {
			settings.camera.position.z += 20
			settings.camera.position.y += 5
		}

	}
}
