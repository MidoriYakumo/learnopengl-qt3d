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
			id: riss
		}

		SkyboxEntity {
			id: skybox
			cameraPosition: riss.camera.position
			baseName: Resources.texture("skybox/skybox")
			extension: ".jpg"
		}


		Entity {
			id: bot
			components: [nanosuit, bot1Transform]

			SceneLoader { // how to inspect
				id: nanosuit
				source: Resources.model("nanosuit.obj")

				onStatusChanged: {
					console.log(status)
					if (status == 2) {
						console.log(bot.count)
					}
				}
			}

			Transform {
				id: bot1Transform
				translation: Qt.vector3d(-4, -8, -20)
				rotation: fromAxisAndAngle(Qt.vector3d(.2, 1., .2), 45)
			}

			GlassPhongMaterial {
				id: material
			}
		}
	}
}
