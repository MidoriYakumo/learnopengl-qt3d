import QtQuick 2.7

Item {
	id: time

	property real value
	property bool running: anime.running

	function getTime(){
		return new Date().getTime()/1000.
	}

	onRunningChanged: {
		if (running) {
			dummy.offset += time.getTime()
			anime.running = running
		}
		else {
			anime.running = running
			dummy.offset -= time.getTime()
		}
	}

	QtObject {
		id: dummy

		property real offset: 0
		property real value

		onValueChanged: {
			time.value = time.getTime() - offset
			//console.log("time.valueChanged", value, time.value)
		}
	}

	NumberAnimation {
		id: anime
		target: dummy
		property: "value"
		duration: 1000
		from: 0
		to: 1

		loops: Animation.Infinite
		running: true
	}
}
