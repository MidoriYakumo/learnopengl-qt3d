/*
* This is the start up QML for qmlscene/compiled version
*/

import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import "Components"

ApplicationWindow {
	id:app
	visible: true
	width: 800
	height: 600 + header.height
	title: "LearnOpenGL-QML"	// Pure QML version by default

	property bool qrcAppOn: false
	property bool qrcAssetsOn: false

	header: ComboBox {
		id: combobox
		background.y: 0  // WARNING: disable extra background (since 5.8)
		background.height: height
		opacity: height / 20
		focusPolicy: Qt.NoFocus
		textRole: "text"
		model: Examples
		currentIndex: -1

		Behavior on height {
			NumberAnimation {
				duration: 400
			}
		}

		onCurrentIndexChanged: {
			if (currentIndex === count - 1)
				Qt.quit();
			load(model.get(currentIndex).source);
		}
	}

	Drawer {
		id: drawer
		width: Math.min(app.width, app.height) * 2 / 3
		height: app.height

		ListView {
			anchors.fill: parent
			currentIndex: -1
			model: Examples
			delegate: ItemDelegate {
				width: parent.width
				text: model.text
				highlighted: ListView.isCurrentItem

				onClicked: {
					if (text === "Exit")
						Qt.quit();
					else {
						app.header.height = 0;
						load(source);
						drawer.close();
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
			focus = true;
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
		//loader.item.unload();
		loader.source = sourceName + ".qml";
	}

	function updateDt(dt) {
		fps3d.fps =  (fps3d.fps * 7 + 1./dt) / 8;
		fps3d.text = (fps3d.fps).toFixed(1) + " fps";
	}

	onQrcAppOnChanged: {
		Resources.appRcEnabled = qrcAppOn;
	}

	onQrcAssetsOnChanged: {
		Resources.assetsRcEnabled = qrcAssetsOn;
	}

	Component.onCompleted: {
		var args = Qt.application.arguments;
		//var arg = args[args.length - 1];
		var arg = args[1];
		if (arg && !/.+\.qml$/.test(arg)) {
			console.log("arg=%1".arg(arg));
			if (parseInt(arg)>=0) {
				combobox.currentIndex = parseInt(arg);
			} else {
				arg = arg.toLowerCase();
				for (var i=0;i<Examples.count;i++) {
					var e = Examples.get(i);
					if (e.text.toLowerCase().search(arg)>=0 || e.source.search(arg)>=0) {
						combobox.currentIndex = i;
						console.log("match=%1.qml".arg(e.source));
						break;
					}
				}
			}
		}
	}
}
