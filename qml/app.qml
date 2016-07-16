import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

import "Components"

ApplicationWindow {
	id:app
	visible: true
	width: 800
	height: 600 + header.height

	header: ComboBox {
		textRole: "text"
		model: Examples { }
		currentIndex: -1
		onCurrentIndexChanged: {
			if (currentIndex === model.count - 1) Qt.quit()
			load(model.get(currentIndex).source)
		}

		Behavior on height {
			NumberAnimation {
				duration: 200
			}
		}
	}

	Drawer {
		id: drawer
		width: Math.min(app.width, app.height) * 2 / 3
		height: app.height

		ListView {
			anchors.fill: parent
			currentIndex: -1
			model: Examples { }
			delegate: ItemDelegate {
				width: parent.width
				text: model.text
				highlighted: ListView.isCurrentItem
				onClicked: {
					if (model.text === "Exit")
						Qt.quit()
					else {
						app.header.height = 0
						load(model.source)
						drawer.close()
					}
				}

			}
		}

	}

	Loader {
		id: loader
		anchors.fill: parent
		sourceComponent: glInfo

		onLoaded: {
			focus = true
		}
	}

	function load(sourceName) {
		loader.item.unload()
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

			signal unload
		}
	}

	FpsItem {
		anchors.top: parent.top
		anchors.topMargin: 8
		anchors.left: parent.left
		anchors.leftMargin: 8
	}

	title: "LearnOpenGL-QML"	// Pure QML version by default
	property bool qrcOn: false  // Load resources from file by default
}
