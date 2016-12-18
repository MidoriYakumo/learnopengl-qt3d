import Qt3D.Render 2.0

RenderSettings {
	id: renderSettings

	property Camera camera

	activeFrameGraph: ClearBuffers {
		buffers: ClearBuffers.ColorDepthBuffer
		clearColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
		RenderSurfaceSelector {
			CameraSelector {
				/*
					CameraSelector gives viewport information so that
					renderer can calculate projectionMatrix for Qt3D Camera

					RenderState.DepthTest ???
				*/

				camera: renderSettings.camera

				RenderStateSet {
					renderStates: DepthTest {
						depthFunction: DepthTest.Less
					}
				}
			}
		}
	}
}
