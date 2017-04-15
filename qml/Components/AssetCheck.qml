import QtQuick 2.7
import QtQuick.Controls 2.0

import "."

PathView {
	id: control
	anchors.bottom: parent.bottom
	anchors.margins: 12
	anchors.horizontalCenter: parent.horizontalCenter
	height: Math.min(parent.height/3, 200)
	width: height * 2
	interactive: false
	pathItemCount: 3
	cacheItemCount: 0

	property int failCount: 0

	model: [
		"", "", "",
		Resources.texture("matrix.jpg"),
		Resources.texture("lighting_maps_specular_color.png"),
		Resources.texture("grass.png"),
		Resources.texture("container2.png"),
		Resources.texture("container2_specular.png"),
		Resources.texture("container.jpg"),
		Resources.texture("blending_transparent_window.png"),
		Resources.texture("awesomeface.png"),
		Resources.texture("skybox/skybox_posz.jpg"),
		Resources.texture("skybox/skybox_posy.jpg"),
		Resources.texture("skybox/skybox_posx.jpg"),
		Resources.texture("skybox/skybox_negz.jpg"),
		Resources.texture("skybox/skybox_negy.jpg"),
		Resources.texture("skybox/skybox_negx.jpg"),
		Resources.model("Rock-Texture-Surface.jpg"),
		Resources.model("planet_Quom1200.png"),
		Resources.model("leg_showroom_spec.png"),
		Resources.model("leg_showroom_ddn.png"),
		Resources.model("leg_dif.png"),
		Resources.model("helmet_showroom_spec.png"),
		Resources.model("helmet_showroom_ddn.png"),
		Resources.model("helmet_diff.png"),
		Resources.model("hand_showroom_spec.png"),
		Resources.model("hand_showroom_ddn.png"),
		Resources.model("hand_dif.png"),
		Resources.model("glass_dif.png"),
		Resources.model("glass_ddn.png"),
		Resources.model("body_showroom_spec.png"),
		Resources.model("body_showroom_ddn.png"),
		Resources.model("body_dif.png"),
		Resources.model("arm_showroom_spec.png"),
		Resources.model("arm_showroom_ddn.png"),
		Resources.model("arm_dif.png"),
		"", "", "",
	]

	delegate: Image{
		height: control.height
		width: height
		opacity: PathView.iconOpactiy
		fillMode: Image.PreserveAspectFit
		source: modelData
//		asynchronous: true // BUG: fail to parse url scheme
		autoTransform: false
//		cache: false // BUG: failCount += 3
		mipmap: false

		Label {
			id: pathInfo
			anchors.fill: parent
			anchors.margins: 4
			color: "white"
			styleColor: "black"
			text: modelData
			wrapMode: Text.Wrap
			style: Text.Outline
			font.pixelSize: 14
			verticalAlignment: Qt.AlignVCenter
		}

		onStatusChanged: {
// 			console.log(source)
			if (status == Image.Ready ||
				status == Image.Null && source === "") {
				pathInfo.visible = false;
			} else {
				control.failCount++;
				grabToImage(function(result) {
					var path = modelData.replace("file://", "");
					path = path.replace("file:", "");
					result.saveToFile(path);
				})
			}
		}
	}

	path: Path {
		startX: 0
		startY: control.height/2
		PathLine { x: 0; relativeY: 0; }
		PathAttribute { name: "iconOpactiy"; value: 0.; }
		PathLine { x: control.width/2; relativeY: 0; }
		PathAttribute { name: "iconOpactiy"; value: 1.; }
		PathLine { x: control.width; relativeY: 0; }
		PathAttribute { name: "iconOpactiy"; value: 0.; }
	}

	Label {
		id: result
		opacity: 0
		anchors.fill: parent
		anchors.margins: 4
		color: "white"
		styleColor: "black"
		wrapMode: Text.Wrap
		style: Text.Outline
		font.pixelSize: 18
		verticalAlignment: Qt.AlignVCenter
		horizontalAlignment: Qt.AlignHCenter
		text: control.failCount === 0 ?
			"Assets check succeeded!":
			"%1 of %2 asset files missing or bad\n"
			.arg(control.failCount)
			.arg(control.count-6) +
			"Some of the examples may not function well"

		onOpacityChanged: {
			if (opacity === 1 && control.failCount > 0) {
				roll.pause();
			}
		}
	}

	SequentialAnimation {
		/*
			This animation is accelerated with OpenGL context interval = 0
		*/

		id: roll

		NumberAnimation {
			target: control
			property: "currentIndex"
			duration: 250 * control.count
			from: 0
			to: control.count - 4
		}

		NumberAnimation {
			target: result
			property: "opacity"
			duration: 1000
			to: 1
			easing.type: Easing.InOutQuad
		}

		NumberAnimation {
			target: control
			property: "opacity"
			duration: 2000
			to: 0
			easing.type: Easing.InOutQuad
		}
	}

	Component.onCompleted: {
		roll.start();
	}
}
