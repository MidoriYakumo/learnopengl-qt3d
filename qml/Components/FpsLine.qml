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

	property real span: d.span
	property int maxFps: 60

	function addDt(dt) {
		var t = d.t + dt
		ser.append(t, 1. / dt)
		while (ser.at(1).x < t - d.span) {
			ser.remove(0)
		}
		d.avg = (ser.count - 1) / (t - ser.at(0).x)
		avgSer.clear()
		d.t = t
		avgSer.append(t - d.span, d.avg)
		avgSer.append(t, d.avg)

		// Math.max(...arr) for ES6
		yAxis.max = (d.avg + 1) * 1.2
	}

	QtObject {
		id: d
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
		min: d.t - d.span
		max: d.t
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
		text: d.avg.toFixed(1) + "fps"
		smooth: false
		antialiasing: false
	}

	onSpanChanged: {
		if (span < 0.1)
			d.span = 0.1
		else if (span > 60)
			d.span = 60
		else
			d.span = span
		span = d.span
	}
}
