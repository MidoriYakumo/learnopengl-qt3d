import QtQuick.Scene3D 2.0

Scene3D {
	id: scene
	height: 600
	width: 800

	focus: true // as InputSettings.eventSource, see examples/controls
	aspects: ["logic", "input"] // logic is required for inputs, result by tests

	signal unload

	onUnload: { // How to unload with InputSetting set to escape from crash?
		focus = false
	}
}
