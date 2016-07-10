import Qt3D.Core 2.0
import Qt3D.Render 2.0

Camera {
	projectionType: CameraLens.PerspectiveProjection
	fieldOfView: 45  // Projection
	aspectRatio: scene.width/scene.height
	nearPlane : 0.1
	farPlane : 100.0
	position: Qt.vector3d(0,0,3) // View
	viewCenter: Qt.vector3d(0,0,0)
	upVector: Qt.vector3d(0,1,0)
}

