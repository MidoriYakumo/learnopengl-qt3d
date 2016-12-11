import QtQuick.Scene3D 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Scene3D {
	/*
		Use Scene3D to create Qt3D scene in QtQuick
		See example: qthelp://org.qt-project.qt3d.570/qt3d/qt3d-scene3d-example.html
		Source:
			qt3d/src/quick3d/imports/scene3d/qtquickscene3dplugin.cpp:48
				qmlRegisterType<Qt3DRender::Scene3DItem>(uri, 2, 0, "Scene3D");
			qt3d/src/quick3d/imports/scene3d/scene3ditem_p.h

	*/

	id: scene
	height: 600
	width: 800

	Entity {
		// Everything starts with this Entity
		RenderSettings {
			// Setup one renderer output
			activeFrameGraph: Viewport {
				// to default Viewport
			}
		}
	}
}
