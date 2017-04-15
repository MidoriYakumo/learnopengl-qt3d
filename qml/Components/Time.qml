import QtQuick 2.7

Item {
	// NOTE: QtQuick animations are based on swapInterval, so time is required
	id: time

	property real value
	property bool running: anime.running

	function getTime(){
		return new Date().getTime()/1000.;
	}

	QtObject {
		id: d

		property real offset: 0
		property real value  // event driver

		onValueChanged: {
			time.value = time.getTime() - offset;
			//console.log("time.valueChanged", value, time.value);
		}
	}

	onRunningChanged: {
		if (running) {
			d.offset += time.getTime();
			anime.running = running;
		}
		else {
			anime.running = running;
			d.offset -= time.getTime();
		}
	}

	NumberAnimation {
		id: anime
		target: d
		property: "value"
		duration: 1000
		from: 0
		to: 1

		loops: Animation.Infinite
		running: true
	}
}
