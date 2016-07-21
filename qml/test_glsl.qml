import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

import "Components"

Scene0 {
	id: scene

	Entity {
		id: root

		RenderInputSettings1 {
			id: riss
		}

		SkyboxEntity {
			id: skybox
			cameraPosition: riss.camera.position
			baseName: Resources.texture("skybox/skybox")
			extension: ".jpg"
		}

		property real angle

		QQ2.NumberAnimation on angle {
			running: true
			duration: 5000
			from: 0
			to: 360
			loops: QQ2.Animation.Infinite
		}

		QQ2.Component.onCompleted: {
			var component = Qt.createComponent("Components/Box2.qml")
			for (var i=0;i<36;i++) {
				var box = component.createObject(root)
				box.index = i
				box.transform.translation = root.randomVec3(30.)
				box.transform.scale3D = root.randomUVec3(5.)
				box.axis = root.randomVec3()
				box.transform.rotation = Qt.binding(function(){
					return dummyTransform.fromAxisAndAngle(
								box.axis, root.angle + box.index * 10.)
				})
			}
		}

		Transform {
			id: dummyTransform
		}

		function randomColor(low, high) {
			if (!low) low = 0.
			if (!high) high = 1.

			var a = Math.random() * (high - low) + low
			var b = Math.random() - .5
			b = .5 + b*(high-low)
			return Qt.hsla(Math.random(), a, b, 1.)
		}

		function randomVec3(size) {
			if (!size) size = 1.
			return Qt.vector3d(
						(Math.random()-.5)*size,
						(Math.random()-.5)*size,
						(Math.random()-.5)*size
						)
		}

		function randomUVec3(size) {
			if (!size) size = 1.
			return Qt.vector3d(
						Math.random()*size,
						Math.random()*size,
						Math.random()*size
						)
		}

	}
}
