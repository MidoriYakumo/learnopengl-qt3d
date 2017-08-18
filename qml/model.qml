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

		property Texture2D diffuseMap: Texture2D {
			TextureImage {
				source: Resources.model("body_dif.png")
			}
		}
		property Texture2D normalMap: Texture2D {
			TextureImage {
				source: Resources.model("body_showroom_ddn.png")
			}
		}
		property Texture2D specularMap: Texture2D {
			TextureImage {
				source: Resources.model("body_showroom_spec.png")
			}
		}

		RenderInputSettings0 {
			id: renderInputSettings

			mouseSensitivity: .5 / Units.dp
		}

		Entity {
			id: plane
			components: [
				PlaneMesh {
					width: 100
					height: 100
				},
				Transform {
					translation: Qt.vector3d(0.0, -1.0, 0.0)
				},
				PhongMaterial {
					ambient: "black"
					diffuse: "coral"
				}
			]
		}

		Entity {
			id: wireframeEntity
			components: [
				Mesh {
					source: Resources.model("nanosuit.obj")
					primitiveType: GeometryRenderer.Lines
				},
				Transform {
					translation: Qt.vector3d(-1.0, -1.0, 0.0)
					rotation: fromAxisAndAngle(Qt.vector3d(0.0 ,1.0 ,0.0), 30.0)
					scale: 0.1
				},
				NormalDiffuseSpecularMapMaterial {
					diffuse: root.diffuseMap
					normal: root.normalMap
					specular: root.specularMap
				}
			]
		}

		Entity {
			id: meshEntity
			components: [
				Mesh {
					source: Resources.model("nanosuit.obj")
				},
				Transform {
					translation: Qt.vector3d(0.0, -1.0, 0.0)
					rotation: fromAxisAndAngle(Qt.vector3d(0.0 ,1.0 ,0.0), 0.0)
					scale: 0.1
				},
				NormalDiffuseSpecularMapMaterial {
					diffuse: root.diffuseMap
					normal: root.normalMap
					specular: root.specularMap
				}
			]
		}

		Entity {
			id: modelEntity
			components: [
				SceneLoader {
					source: Resources.model("nanosuit.obj")
				},
				Transform {
					translation: Qt.vector3d(1.0, -1.0, 0.0)
					rotation: fromAxisAndAngle(Qt.vector3d(0.0, 1.0, 0.0), -30.0)
					scale: 0.1
				}
			]
		}

		Entity {
			id: light
			components: DirectionalLight {
				color: "white"
				intensity: 3
				worldDirection: Qt.vector3d(0.0, -1.0, -1.0)
			}
		}
	}
}
