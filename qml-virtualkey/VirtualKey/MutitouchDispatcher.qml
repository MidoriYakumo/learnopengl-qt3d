import QtQuick 2.7

import "."

MultiPointTouchArea {
	id: touch
	anchors.fill: target
	mouseEnabled: false

	property Item target: parent
	// enable for faster response but stick and drag while moving
	property bool stickAndDrag: !mouseEnabled
	// perform drag on each point (multidrag)
	property bool simulateDrag: false
	// less drag event
	property bool accumulateDrag: simulateDrag
	// show ripple helper on touch event
	property bool touchVisualize: false

	QtObject {
		id: d
//		property bool accumulateDrag: touch.accumulateDrag && touch.simulateDrag
		property var prevPoints: ({})
	}

	TouchVisualRipple {
		id: ripple
	}

	InputEventDefer {
		id: defer
		pauseInput: !stickAndDrag
	}

	onPressed: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (touchVisualize)
				ripple.create(p.x, p.y, parent, "lime")
			if (accumulateDrag)
				d.prevPoints[p.pointId] = {x:p.x,y:p.y}

			defer.push({
				x:p.x, y:p.y,
				act: function(){
					target.focus = true
					InputEventSource.mousePress(target,
						this.x, this.y,
						Qt.LeftButton, Qt.NoModifier, -1
					)
				}
			})
		}

		defer.start()
	}

	onReleased: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (touchVisualize)
				ripple.create(p.x, p.y, parent, "slateblue")
			if (accumulateDrag)
				delete d.prevPoints[p.pointId]

			defer.push({
				x:p.x, y:p.y,
				act: function(){
					target.focus = true
					InputEventSource.mouseRelease(target,
						this.x, this.y,
						Qt.LeftButton, Qt.NoModifier, -1
					)
				}
			})
		}

		defer.start()
	}

	onUpdated: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			var sx = p.previousX, sy = p.previousY
			if (accumulateDrag) {
				var dx = p.x-d.prevPoints[p.pointId].x
				var dy = p.y-d.prevPoints[p.pointId].y
				if (dx*dx+dy*dy<InputEventSource.threshold2)
					continue
				sx = d.prevPoints[p.pointId].x
				sy = d.prevPoints[p.pointId].y
				d.prevPoints[p.pointId] = {x:p.x,y:p.y}
			}

			if (touchVisualize) // only draw with event
				ripple.create(p.x, p.y, parent, "teal")

			defer.push(simulateDrag?
				{
					x:p.x, y:p.y, px: sx, py: sy,
					act: function(){
						target.focus = true
						InputEventSource.mouseDrag(target,
							this.px, this.py, this.x, this.y,
							Qt.LeftButton, Qt.NoModifier, -1
						)
					}
				}:{
				   x:p.x, y:p.y,
				   act: function(){
					   target.focus = true
					   InputEventSource.mouseMove(target,
						   this.x, this.y, -1, Qt.LeftButton
					   )
				   }
				}
			)
		}

		defer.start()
	}

//	onCanceled: {
//		for (var i in touchPoints) {
//			var p = touchPoints[i]
//			if (touchVisualize)
//				ripple.create(p.x, p.y, parent, "crisom")

//			defer.push({
//				x:p.x, y:p.y,
//				act: function(){
//					target.focus = true
//					InputEventSource.mouseRelease(target,
//						this.x, this.y,
//						Qt.LeftButton, Qt.NoModifier, -1
//					)
//				}
//			})
//		}

//		defer.start()
//	}

	// TODO: add two finger to wheel convertion
}
