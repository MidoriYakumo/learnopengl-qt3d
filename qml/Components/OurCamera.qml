import Qt3D.Render 2.0

Camera {
	id: ourCamera

	property real yaw: 0
	property real pitch: 0

	property vector3d frontVector: Qt.vector3d(
			 Math.cos(pitch * Math.PI / 180.) * Math.sin(yaw * Math.PI / 180.),
			-Math.sin(pitch * Math.PI / 180.),
			-Math.cos(pitch * Math.PI / 180.) * Math.cos(yaw * Math.PI / 180.)
	)
	property vector3d rightVector: frontVector.crossProduct(upVector).normalized()

	projectionType: CameraLens.PerspectiveProjection
	fieldOfView: 45  // Projection
	aspectRatio: scene.width/scene.height
	nearPlane : .1
	farPlane : 100.
	position: "0,0,3"// View
	viewCenter: position.plus(frontVector)
	upVector: "0,1,0"
}
