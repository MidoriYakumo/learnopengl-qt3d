pragma Singleton

import QtQuick 2.7

import Qt3D.Input 2.0

InputSettings {
	property var defaultParent: parent

	Component.onCompleted: {
		console.log("InputSettings instantiated")
		console.log("parent:%1, eventSource:%2".arg(defaultParent).arg(eventSource))
	}
}
