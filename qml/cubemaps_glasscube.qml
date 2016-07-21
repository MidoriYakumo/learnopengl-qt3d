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

		NodeInstantiator {
//			asynchronous: true // crash when loading scene
			model: 36
			delegate: GlassBox0 {
				material.ambient : root.randomColor(.5)
				material.diffuse : root.randomColor(.9)
				material.specular : root.randomColor()
				material.shininess : Math.random() * 200. + 1.
				material.refractive : Math.pow(Math.random() + 1., .2)
				material.transparency : Math.pow(Math.random(), .3)
				material.skyboxTexture : skybox.skyboxTexture
				transform.translation : root.randomVec3(30.)
				transform.scale3D : root.randomUVec3(5.)
				axis : root.randomVec3()
				transform.rotation : dummyTransform.fromAxisAndAngle(
							axis, root.angle + index * 10.)

			}
		}

//		QQ2.Component.onCompleted: {
//			var component = Qt.createComponent("Components/GlassBox0.qml")
//			for (var i=0;i<36;i++) {
//				var box = component.createObject(root)
//				box.index = i
//				box.material.ambient = root.randomColor(.5)
//				box.material.diffuse = root.randomColor(.9)
//				box.material.specular = root.randomColor()
//				box.material.shininess = Math.random() * 200. + 1.
//				box.material.refractive = Math.pow(Math.random() + 1., .2)
//				box.material.transparency = Math.pow(Math.random(), .3)
//				box.material.skyboxTexture = skybox.skyboxTexture
//				box.transform.translation = root.randomVec3(30.)
//				box.transform.scale3D = root.randomUVec3(5.)
//				box.axis = root.randomVec3()
//				box.transform.rotation = Qt.binding(function(){
//					return dummyTransform.fromAxisAndAngle(
//								box.axis, root.angle + box.index * 10.)
//				})
//			}
//		}

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
