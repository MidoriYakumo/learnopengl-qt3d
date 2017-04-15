import QtQuick 2.7
import QtCharts 2.1

ChartView {
	id: app // name it with app in scene to display fps without QML/GL window
	anchors.top: parent.top
	anchors.right: parent.right
	anchors.margins: {
		top: vMargin
		right: hMargin
	}
	width: 160
	height: 94

	property int hMargin: 6
	property int vMargin: 6

	property real span: d.span
	property real maxMargin: .5

	function updateDt(dt) {
		var t = d.t + dt;

		ser.append(t, 1. / dt);
		while (ser.at(1).x < t - d.span) {
			ser.remove(0);
		}

		d.t = t;
		d.avg = (ser.count - 1) / (t - ser.at(0).x);

		avgSer.clear();
		avgSer.append(t - d.span, d.avg);
		avgSer.append(t, d.avg);

		// TODO: Math.max(...arr) for ES6
		yAxis.max = (d.avg + 1) * (1. + maxMargin);
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
	backgroundColor: "#801b813e"
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
		max: 60
		labelsColor: "white"
		tickCount: 4
		minorGridVisible: false
		minorTickCount: 0
		shadesVisible: false
		labelsFont.pixelSize: 18
		labelFormat: "%2d"

//		Behavior on max {  // may impact fps
//			NumberAnimation {
//				duration: 400
//			}
//		}
	}

	LineSeries {
		id: avgSer
//		useOpenGL : true
		color: "#00E2FF"
		width: 5
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
		x: app.plotArea.x - 4
		y: app.height - 30
		color: "white"
		font.pixelSize: 16
		text: d.avg.toFixed(1) + "fps"
		smooth: false
		antialiasing: false
	}

	onSpanChanged: {
		if (span < .1)
			d.span = .1;
		else if (span > 60)
			d.span = 60;
		else
			d.span = span;

		span = d.span;
	}
}
