import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Scene0 {
	id: scene
	Entity {
		id: root

		Camera {
			id: camera
			projectionType: CameraLens.PerspectiveProjection
			fieldOfView: 45  // Projection
			aspectRatio: scene.width/scene.height
			nearPlane : 0.1
			farPlane : 100.0
			position: Qt.vector3d( 0.0, 0.0, 3.0 ) // View
		}

		RenderSettings {
			id: renderSettings
			activeFrameGraph: ClearBuffers {
				buffers: ClearBuffers.ColorDepthBuffer
				clearColor: Qt.rgba(0.2, 0.3, 0.3, 1.0)
				RenderSurfaceSelector {
					CameraSelector {
						camera: camera
					}
				}
			}
		}

		property var cubePositions: [
			Qt.vector3d( 0.0,  0.0,  0.0),
			Qt.vector3d( 2.0,  5.0, -15.0),
			Qt.vector3d(-1.5, -2.2, -2.5),
			Qt.vector3d(-3.8, -2.0, -12.3),
			Qt.vector3d( 2.4, -0.4, -3.5),
			Qt.vector3d(-1.7,  3.0, -7.5),
			Qt.vector3d( 1.3, -2.0, -2.5),
			Qt.vector3d( 1.5,  2.0, -2.5),
			Qt.vector3d( 1.5,  0.2, -1.5),
			Qt.vector3d(-1.3,  1.0, -1.5)
		]

//		property list<Box0> boxes:[ // No Append method !!! / readonly ???
//			Box0{ }, Box0{ }, Box0{ }, Box0{ }, Box0{ },
//			Box0{ }, Box0{ }, Box0{ }, Box0{ }, Box0{ }
//		]

		QQ2.Component.onCompleted: {
			var component = Qt.createComponent("Box0.qml")
			for (var i in cubePositions) {
				var box = component.createObject(root)
				var transform = Qt.createQmlObject("import Qt3D.Core 2.0;
					Transform {
						rotation: fromAxisAndAngle(Qt.vector3d(1, .3, 5), root.angle*%1)
					}".arg(i), box); // Dirty binding and namespace
				transform.translation = cubePositions[i]
				box.transform = transform
//				box.transform.rotation = Transform.fromAxisAndAngle(Qt.vector3d(1, .3, 5), root.angle) // Error
			}
		}


//		QQ2.Repeater { // Not Entity !!!
//			id: repeater
//			model: root.cubePositions
//			delegate: Box0 {
//				transform: Transform {
//					translation: data
//				}
//			}
//		}

		property real angle

		QQ2.NumberAnimation {
			target: root
			property: "angle"
			duration: 360*1000/20
			from: 0
			to: 360

			loops: QQ2.Animation.Infinite
			running: true
		}
	}
}
