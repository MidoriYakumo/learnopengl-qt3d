import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

Entity {

	property alias mouseSensitivity: cameraController.mouseSensitivity
	readonly property alias camera: ourCamera

	RenderSettings2 {
		camera: ourCamera
	}

	InputSettings {}

	OurCamera {
		id: ourCamera
	}

	OurCameraController {
		id: cameraController

		camera: ourCamera
	}
}
