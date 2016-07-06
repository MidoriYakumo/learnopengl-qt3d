import QtQuick 2.6 as QQ2
import QtQuick.Scene3D 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

Scene3D {
	id:scene
	height:600
	width:800

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
