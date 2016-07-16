import Qt3D.Render 2.0

RenderSettings {
	id: renderSettings
	property Camera camera
	activeFrameGraph: ClearBuffers {
		buffers: ClearBuffers.ColorDepthBuffer
		clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
		RenderSurfaceSelector {
			CameraSelector {  // Camera installed
				camera: renderSettings.camera
			}
		}
	}
}
