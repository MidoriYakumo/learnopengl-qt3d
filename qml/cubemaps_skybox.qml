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

		SkyboxEntity { //optimized by Qt, !! 2048 may get GL_OUT_OF_MEMORY
			cameraPosition: riss.camera.position
			baseName: Resources.texture("skybox/skybox")
			extension: ".jpg"
		}

		Box1 {
			ambient: "white"
		}

	}
}
