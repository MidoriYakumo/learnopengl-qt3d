import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0

Entity {
	id: root

	property Entity camera
	property alias mouseSensitivity: mouseDevice.sensitivity // 0.5 / Units.dp

	KeyboardDevice {
		id: keyboardDevice
	}

	MouseDevice {
		id: mouseDevice
	}

	LogicalDevice {
		enabled: true
		actions: Action {
			id: mouseClick
			ActionInput {
				sourceDevice: mouseDevice
				buttons: [MouseEvent.LeftButton]
			}
		}
		axes: [
			Axis {
				id: xAxis
				AnalogAxisInput {
					sourceDevice: mouseDevice
					axis: MouseDevice.X
				}
			},
			Axis {
				id: yAxis
				AnalogAxisInput {
					sourceDevice: mouseDevice
					axis: MouseDevice.Y
				}
			}
		]
	}

	FrameSwap {
		onTriggered: {
			if (mouseClick.active) {
				root.camera.panAboutViewCenter(xAxis.value * -1e2 * dt)
				root.camera.tiltAboutViewCenter(yAxis.value * -1e2 * dt)
			}
		}
	}
}
