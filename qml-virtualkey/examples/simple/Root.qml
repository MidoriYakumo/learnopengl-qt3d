import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
	width: 800
	height: 600

	Column {
		width: 200
		anchors.centerIn: parent
		anchors.horizontalCenterOffset: 40
		spacing: 6

		TextField {
			Label {
				text: "Email:"
				anchors.right: parent.left
				anchors.margins: 8
				verticalAlignment: Text.AlignVCenter
				height: parent.height
			}
		}
		TextField {
			Label {
				text: "Username:"
				anchors.right: parent.left
				anchors.margins: 8
				verticalAlignment: Text.AlignVCenter
				height: parent.height
			}
		}
		TextField {
			echoMode: TextInput.Password

			Label {
				text: "Password:"
				anchors.right: parent.left
				anchors.margins: 8
				verticalAlignment: Text.AlignVCenter
				height: parent.height
			}
		}
	}
}
