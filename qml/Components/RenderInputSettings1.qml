import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Entity {
	property Camera camera:Camera0 {
		id:camera
	}

	RenderSettings {
		activeFrameGraph: ForwardRenderer {
			clearColor: Qt.rgba(.1, .1, .1, 1.0)
			camera: camera
		}
	}

	Inputs0 {
		camera: camera
	}
}

