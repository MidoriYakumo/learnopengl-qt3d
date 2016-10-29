pragma Singleton

import QtTest 1.1

TestEvent {
	property var dummyKeyEvent
	property int threshold: util.dragThreshold+1
	property int threshold2: threshold*threshold

	property TestUtil util: TestUtil { }

	function mouseDrag(item, sx, sy, ex, ey, button, modifiers, delay) {
		mousePress(item, sx, sy, button, modifiers, delay)
		var dx, dy
		dx = ex>sx?threshold:-threshold
		dy = ey>sy?threshold:-threshold
		mouseMove(item,	sx + dx, sy + dy, delay, button) // forward move > threshold
		mouseMove(item,	(sx + ex)/2 + dx, (sy + ey)/2 + dy, delay, button) // forward move
		mouseMove(item, ex + dx, ey + dy, delay, button) // forward move
		mouseRelease(item, ex, ey, button, modifiers, delay)
	}
}
