import Qt3D.Logic 2.0

FrameAction {
	id: frameSwap

	property int cnt
	property real adt

	onTriggered: {
		try {
			adt += dt
			cnt++
			if (cnt >= 3) {
				app.updateDt(adt/cnt)
				adt = 0
				cnt = 0
			}
		} catch (e) {

		}
	}
}
