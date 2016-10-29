import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

import "."

Item  {
	id: vkeys

	anchors.fill: overlay?overlayTarget:parent
	visible: controls.opacity>0
	property bool active: ["android", "ios"].indexOf(Qt.platform.os)>=0

	property Item target: root
	property var targetHandler: null
	property var overlayTarget: target

	property bool overlay: true
	property bool enablePad: true
	property bool enableGameButtons: true
	property alias color: controls.color

	property int modifiers

	property alias centerItem: controls.centerItem

	Rectangle {
		visible: vkeys.overlay
		gradient: Gradient {
			GradientStop { position: 0; color:"transparent" }
			GradientStop { position: 1; color:"#40000000" }
		}
		anchors.bottom: controls.top
		width: controls.width
		height: Units.dp * 8
		opacity: controls.color.a * controls.opacity
	}

	Rectangle {
		id: controls
		height: Units.dp * 16 + Math.max(centerItem.height,
			Math.max(vkeys.enablePad?virtualpad.height:0,
				vkeys.enableGameButtons?gameButtons.height:0)
			)

		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom

		property alias target: vkeys.target
		property alias targetHandler: vkeys.targetHandler
		property alias modifiers: vkeys.modifiers

		opacity: (vkeys.height-y)/height
		clip: opacity > 0 && color.a > 0
		color: Material.backgroundColor

		property Item centerItem: Item { }

		VirtualPad {
			id: virtualpad
			visible: enablePad
			opacity: (overlay && parent.color.a===0)?.7:1.
			height: Units.dp * 64 * 3
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.margins: Units.dp * 8
			target: vkeys.target
			targetHandler: vkeys.targetHandler
		}

		GameButtons {
			id: gameButtons
			visible: enableGameButtons
			opacity: (overlay && parent.color.a===0)?.7:1.
			height: Units.dp * 64 * 3
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			anchors.margins: Units.dp * 8
			target: vkeys.target
//			targetHandler: vkeys.targetHandler
		}
	}

	onActiveChanged:
		if (active)
			inAnime.start()
		else
			outAnime.start()

	NumberAnimation {
		id: inAnime
		target: controls
		property: "anchors.bottomMargin"
		duration: 400
		to: 0
	}

	NumberAnimation {
		id: outAnime
		target: controls
		property: "anchors.bottomMargin"
		duration: 400
		to: -controls.height
	}

	function setCenterItemCenter() {
		if (!centerItem) return;
		var r = 0
		if (enablePad)
			r += virtualpad.width
		if (enableGameButtons)
			r -= gameButtons.width
			centerItem.anchors.horizontalCenterOffset = r/2
	}

	onEnableGameButtonsChanged: setCenterItemCenter()
	onEnablePadChanged: setCenterItemCenter()
	onCenterItemChanged: setCenterItemCenter()

	Component.onCompleted: {
		centerItem.parent = controls
//		centerItem.anchors.horizontalCenter = controls.horizontalCenter
		anchors.bottomMargin = active?0:-controls.height
		overlayTarget.anchors.bottomMargin = Qt.binding(function(){
			return (overlay||!active)?0:controls.height
		})

		console.log("VirtualKeys.targetHandler:", targetHandler)
	}
}
