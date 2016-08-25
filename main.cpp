#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickItem>
#include <QOpenGLContext>

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);

	QSurfaceFormat format;
	if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGL) { // Learn OpenGL
		format.setVersion(4, 3);
		format.setProfile(QSurfaceFormat::CoreProfile);
	} else if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGLES) { // Learn OpenGLES??
		format.setVersion(3, 0);
	}

	format.setAlphaBufferSize(0);
	format.setDepthBufferSize(0);
	format.setRenderableType(QSurfaceFormat::OpenGL);
	format.setSamples(4);
	format.setStencilBufferSize(0);
	format.setSwapBehavior(QSurfaceFormat::TripleBuffer);
	format.setSwapInterval(0); // For full speed

	QSurfaceFormat::setDefaultFormat(format);

	QQuickStyle::setStyle("Material");

	QQmlApplicationEngine engine;

#ifndef NO_APP_QRC
	engine.load(QUrl(QLatin1String("qrc:/qml/app-cpp.qml"))); // If qtcharts crashes the program
// 	engine.load(QUrl(QLatin1String("qrc:/qml/app.qml")));
#else
	engine.load(QUrl(QLatin1String("file:../qml/app-cpp.qml")));
// 	engine.load(QUrl(QLatin1String("file:../qml/app.qml")));
#endif

#ifndef NO_ASSETS_QRC
	engine.rootObjects().at(0)->setProperty("qrcOn", true);
#endif

	engine.rootObjects().at(0)->setProperty("title", "LearnOpenGL-Qt3D");

	return app.exec();
}
