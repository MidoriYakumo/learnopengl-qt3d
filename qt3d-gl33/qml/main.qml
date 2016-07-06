import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
	id:app
	visible: true
	title: qsTr("LearnOpenGL-Qt3D")
	width: 800
	height: 600 + tabBar.height

	SwipeView {
		id: swipeView
		currentIndex: tabBar.currentIndex
		anchors.fill:parent

		Rectangle {
//			color: "black"

			HelloWindow {

			}

			Text {
				color: "white"
				anchors.centerIn: parent
				text: "OpenGL %1.%2 %3 Render %4"
				.arg(OpenGLInfo.majorVersion)
				.arg(OpenGLInfo.minorVersion)
				.arg({0:"NoProfile",
					1:"CoreProfile",
					2:"CompatibilityProfile", }
					[OpenGLInfo.profile])
				.arg({0:"Unspecified",
					1:"GL",
					2:"GLES",}
					[OpenGLInfo.renderableType])
				styleColor: "#8b8b8b"
				style: Text.Sunken
				font.pointSize: 24
			}

		}

		HelloTriangle {}
		HelloTriangle2 {}
		ShadersUniform {}
		ShadersInterpolated {}

//		Test0 {}
//		Test1 {}
//		Test2 {}
//		Test3 {}
//		Test4 {}
//		Test5 {}
//		Test6 {}
	}

	footer: TabBar {
		id: tabBar
		currentIndex: swipeView.currentIndex

		TabButton { text: "Hello Window" }
		TabButton { text: "Hello Triangle" }
		TabButton { text: "Hello Tri 2 WF" }
		TabButton { text: "Shaders Uniform" }
		TabButton { text: "Shaders Interpolated" }

//		TabButton { text: "Test0" }
//		TabButton { text: "Test1" }
//		TabButton { text: "Test2" }
//		TabButton { text: "Test3" }
//		TabButton { text: "Test4" }
//		TabButton { text: "Test5" }
//		TabButton { text: "Test6" }
	}

	signal init

	Component.onCompleted: init()
}
