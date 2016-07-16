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
		model: Examples { }
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

	FpsItem {
		anchors.top: parent.top
		anchors.topMargin: 8 + combo.height
		anchors.left: parent.left
		anchors.leftMargin: 8
		spinnerSource: Resources.image("spinner.png")
	}

}
