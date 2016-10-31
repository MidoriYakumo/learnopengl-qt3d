import QtQuick 2.7
import Qt3D.Logic 2.0

FrameAction {
	id: frameSwap

	QtObject {
		id: d

		property int cnt
		property real adt
	}

	onTriggered: {
		try {
			d.adt += dt
			d.cnt++
			if (d.cnt >= 3) {
				app.updateDt(d.adt/d.cnt)
				d.adt = 0
				d.cnt = 0
			}
		} catch (e) {

		}
	}
}
