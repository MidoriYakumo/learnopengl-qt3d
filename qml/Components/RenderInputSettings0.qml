import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
	property Camera camera:Camera0 {
		id:camera
	}

	RenderSettings1 {
		camera: camera
	}

	Inputs0 {
		camera: camera
	}
}

