pragma Singleton

import QtQuick 2.7
import QtQuick.Window 2.2

QtObject {
	readonly property real pixelDensity: useLogicalPixelDensity?
		Screen.logicalPixelDensity:
		Screen.pixelDensity

	readonly property real dp: pixelDensity*25.4*multiplier/160.
	readonly property real gu: dp * 64

	property bool useLogicalPixelDensity: false
	property real multiplier: 1.0

}
