import QtQuick.Scene3D 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Scene3D {
	id: scene
	height: 600
	width: 800

	Entity {
		RenderSettings {
			activeFrameGraph: ClearBuffers {
				// ClearBuffers inherits from FrameGraphNode, as output framegraph
				buffers: ClearBuffers.ColorBuffer // To clear color buffer
				clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0) // = glClearColor
				RenderSurfaceSelector {
					// Default render output: window surface
				}
			}
		}
	}
}
