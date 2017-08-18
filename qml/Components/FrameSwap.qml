import QtQuick 2.9
import Qt3D.Logic 2.0

FrameAction {
	id: frameSwap

	QtObject {
		id: d

		property int cnt
		property real accdt
	}

	onTriggered: {
		try {
			var accdt = d.accdt + dt;
			var cnt = d.cnt + 1;
			if (cnt >= 3) {
				app.updateDt(accdt/cnt); // throw
				accdt = 0;
				cnt = 0;
			}
			d.accdt = accdt;
			d.cnt = cnt;
		} catch (e) {

		}
	}
}
