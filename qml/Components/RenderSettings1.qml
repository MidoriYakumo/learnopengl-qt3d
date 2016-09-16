import Qt3D.Render 2.0

RenderSettings {
	activeFrameGraph: ClearBuffers {
		buffers: ClearBuffers.ColorDepthBuffer
		clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
		RenderSurfaceSelector {
			RenderStateSet {
				renderStates: DepthTest {
					depthFunction: DepthTest.Less
				}
			}
		}
	}
}
