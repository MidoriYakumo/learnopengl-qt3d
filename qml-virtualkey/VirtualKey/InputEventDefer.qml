/*
  Add input event into eventloop asynchronously
*/

import QtQuick 2.7

Item {
	id: defer

	property Item input: parent
	property bool pauseInput: true

	signal finished()

	QtObject {
		id: d

		property var queue: []
	}

	Timer {
		id: timer

		interval: 0
		repeat: false

		onTriggered: {
			if (pauseInput)
				input.enabled = false
			while (d.queue.length) {
				var event = d.queue.shift()
				event.act()
			}
			if (pauseInput)
				input.enabled = true
			defer.finished()
		}
	}

	function push(event) {
		if (event["act"])
			d.queue.push(event)
		else
			console.warn("Event %1 has no 'act' method".arg(event))
	}

	function start(){
		timer.start()
	}
}
