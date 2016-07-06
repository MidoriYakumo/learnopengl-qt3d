import QtQuick 2.6

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Scene0 {
	Entity {
		id: root

		RenderSettings {
			id: renderSettings
			activeFrameGraph: ClearBuffers {
				buffers: ClearBuffers.ColorBuffer
				clearColor: "black"
				RenderSurfaceSelector {
				}
			}
		}
	}
}
