/*
* This is the start up QML for QML Creator
*/

import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import "Components"

Item {
	id: main
	anchors.fill: parent

	QtObject {
		id: app

		function updateDt(dt) {
			fps3d.fps =  (fps3d.fps * 7 + 1./dt) / 8;
			fps3d.text = (fps3d.fps).toFixed(1) + " fps";
		}

	}

	Loader {
		id: loader
		anchors.fill: parent
		sourceComponent: glInfo

		onLoaded: {
			focus = true;
		}
	}

	ComboBox {
		id: combo
		background.y: 0  // disable extra background (since 5.8)
		background.height: height
		focusPolicy: Qt.NoFocus
		textRole: "text"
		width: parent.width
		anchors.top: parent.top
		model: Examples
		currentIndex: -1

		onCurrentIndexChanged: {
			load(model.get(currentIndex).source);
		}
	}

	//	FpsItem {
	//		id: fps2d
	//		anchors.top: parent.top
	//		anchors.topMargin: 8
	//		anchors.left: parent.left
	//		anchors.leftMargin: 8
	//		spinnerSource: Resources.image("spinner.png")
	//	}

	Text {
		id: fps3d
		anchors.right: parent.right
		anchors.rightMargin: 8
		anchors.top: combo.bottom
		anchors.topMargin: 8
		color: "#ff7e91"
		style: Text.Outline
		styleColor: "#7a2729"
		font.pointSize: 18

		property real fps: 60.
	}

	Component {
		id: glInfo
		Rectangle {
			color: "black"
			Text {
				color: "white"
				anchors.centerIn: parent
				text: "Open%4 %1.%2 %3".arg(
					OpenGLInfo.majorVersion).arg(
					OpenGLInfo.minorVersion).arg({
						0: "NoProfile",
						1: "CoreProfile",
						2: "CompatibilityProfile"
					}[OpenGLInfo.profile]).arg({
						0: "Unspecified",
						1: "GL",
						2: "GLES"
					}[OpenGLInfo.renderableType])
				styleColor: "#8b8b8b"
				style: Text.Sunken
				font.pointSize: 24

				onTextChanged: {
					Resources.setGlInfo(OpenGLInfo);
				}
			}

			AssetCheck {}
		}
	}

	function load(sourceName) {
		loader.source = sourceName + ".qml";
	}
}
