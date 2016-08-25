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

	Loader {
		id: loader
		anchors.fill: parent
		sourceComponent: glInfo
	}

	ComboBox {
		id: combo
		textRole: "text"
		width: parent.width
		anchors.top: parent.top
		model: Examples
		currentIndex: -1
		onCurrentIndexChanged: load(model.get(currentIndex).source)
	}

	function load(sourceName) {
		loader.source = sourceName + ".qml"
	}

	Component {
		id: glInfo
		Rectangle {
			color: "black"
			Text {
				color: "white"
				anchors.centerIn: parent
				text: "OpenGL %1.%2 %3 Render %4".arg(
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
			}
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

	QtObject {
		id: app

		function updateDt(dt) {
			fps3d.fps =  (fps3d.fps * 7 + 1./dt) / 8
			fps3d.text = (fps3d.fps).toFixed(1) + " fps"
		}

	}

	Text {
		id: fps3d
		anchors.right: parent.right
		anchors.rightMargin: 8
		anchors.top: parent.top
		anchors.topMargin: 8
		color: "#ff7e91"
		style: Text.Outline
		styleColor: "#7a2729"
		font.pointSize: 18
		property real fps: 60.
	}
}
