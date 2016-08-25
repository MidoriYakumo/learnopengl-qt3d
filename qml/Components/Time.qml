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

	property int counter: 0
	onValueChanged: {
		counter ++
		if (counter >= 60) {
			counter = 0
			console.log("[Time] +1s: %1 %2".arg(value).arg(parseInt(new Date().getTime())))
		}

		//console.log("[Time] %1".arg(value))
	}
}
