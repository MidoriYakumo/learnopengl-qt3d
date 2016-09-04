import Qt3D.Render 2.0

RenderSettings {
	activeFrameGraph: ClearBuffers { // Simplest FrameGraphNode, see src/ClearBuffers
		buffers: ClearBuffers.ColorDepthBuffer // Why not ColorBuffer only??? , result by tests
		clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
		RenderSurfaceSelector { // Needed by console prompts
		}
	}
}
