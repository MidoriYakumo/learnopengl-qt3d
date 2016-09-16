import QtQuick 2.0
import QtCharts 2.1

ChartView {
	id: root
	anchors.top: parent.top
	anchors.right: parent.right
	anchors.margins: {
		top: vMargin
		right: hMargin
	}
	height: 92
	width: 160

	property int vMargin: 6
	property int hMargin: 6

	property real span: pri.span
	property int maxFps: 60

	onSpanChanged: {
		if (span < 0.1)
			pri.span = 0.1
		else if (span > 60)
			pri.span = 60
		else
			pri.span = span
		span = pri.span
	}

	function addDt(dt) {
		var t = pri.t + dt
		ser.append(t, 1. / dt)
		while (ser.at(1).x < t - pri.span) {
			ser.remove(0)
		}
		pri.avg = (ser.count - 1) / (t - ser.at(0).x)
		avgSer.clear()
		pri.t = t
		avgSer.append(t - pri.span, pri.avg)
		avgSer.append(t, pri.avg)

		// Math.max(...arr) for ES6
		yAxis.max = (pri.avg + 1) * 1.2
	}

	QtObject {
		id: pri
		property real t: 0.
		property real span: 2.
		property real avg: 0.
	}

//	animationDuration: 100
//	animationOptions: ChartView.GridAxisAnimations
	animationOptions: ChartView.NoAnimation
	backgroundColor: "#a0008000"
	backgroundRoundness: 0
	margins.top: 0
	margins.bottom: 0
	margins.left: 0
	margins.right: 0
	legend.visible: false
	antialiasing: true
	smooth: true

	ValueAxis {
		id: xAxis
		min: pri.t - pri.span
		max: pri.t
		visible: false
	}

	ValueAxis {
		id: yAxis
		min: 0
		max: root.maxFps
		labelsColor: "white"
		minorGridVisible: false
		minorTickCount: 0
		shadesVisible: false
		labelsFont.pixelSize: 18
		labelFormat: "%2.0f"
	}

	LineSeries {
		id: avgSer
//		useOpenGL : true
		color: "#00E2FF"
		width: 4
		axisX: xAxis
		axisY: yAxis
	}

	LineSeries {
		id: ser
//		useOpenGL : true
		color: "#ff7e91"
		width: 3
		axisX: xAxis
		axisY: yAxis
		XYPoint {
			x: 0
			y: 0
		}
	}

	Text {
		id: realtime
		x: root.plotArea.x - 3
		y: 8
		color: "white"
		font.pixelSize: 16
		text: pri.avg.toFixed(1) + "fps"
		smooth: false
		antialiasing: false
	}

}
