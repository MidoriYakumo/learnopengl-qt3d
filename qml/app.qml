/*
* This is the start up QML for qmlscene/compiled version
* QtCharts may crash the application in non-default context
*/

import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

import "Components"

ApplicationWindow {
	id: app
	visible: true
	width: 800
	height: 600 + header.height
	title: "LearnOpenGL-QML"	// Pure QML version by default

	property bool qrcAppOn: false
	property bool qrcAssetsOn: false

	header: ComboBox {
		id: combobox
		wheelEnabled: true
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

	FpsLine {
		id: fps3d
		span: 2.
	}

	Component {
		id: glInfo
		Rectangle {
			color: "black"
			Text {
				color: "white"
				anchors.centerIn: parent
				text: "Open%4 %1.%2 %3".arg(
					GraphicsInfo.majorVersion).arg(
					GraphicsInfo.minorVersion).arg({
						0: "NoProfile",
						1: "CoreProfile",
						2: "CompatibilityProfile"
					}[GraphicsInfo.profile]).arg({
						0: "Unspecified",
						1: "GL",
						2: "GLES"
					}[GraphicsInfo.renderableType])
				styleColor: "#8b8b8b"
				style: Text.Sunken
				font.pointSize: 24

				onTextChanged: {
					Resources.setGlInfo(GraphicsInfo);
				}
			}

			AssetCheck {}
		}
	}

	Shortcut {
		context: Qt.ApplicationShortcut
		sequence: "F11"

		onActivated: {
			showFullScreen();
		}
	}

	function load(sourceName) {
		//loader.item.unload();
		loader.source = sourceName + ".qml";
	}

	function updateDt(dt) {
		fps3d.updateDt(dt);
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
