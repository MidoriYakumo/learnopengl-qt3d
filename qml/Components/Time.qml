import QtQuick 2.7

Item {
	id: time
	property real value
	property real cycle: Math.PI * 2

	NumberAnimation {
		target: time
		property: "value"
		duration: time.cycle * 1000
		from: 0
		to: time.cycle

		loops: Animation.Infinite
		running: true
	}
}
