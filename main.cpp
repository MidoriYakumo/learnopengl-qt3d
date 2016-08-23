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
		format.setVersion(2, 0);
	}

	format.setAlphaBufferSize(0);
	format.setDepthBufferSize(0);
	format.setRenderableType(QSurfaceFormat::OpenGL);
	format.setSamples(4);
	format.setStencilBufferSize(0);
	format.setSwapBehavior(QSurfaceFormat::TripleBuffer);
	format.setSwapInterval(0);

	QSurfaceFormat::setDefaultFormat(format);

	QQuickStyle::setStyle("Material");

	QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/app-cpp.qml"))); // If qtcharts crashes the program
// 	engine.load(QUrl(QLatin1String("qrc:/qml/app.qml")));
	engine.rootObjects().at(0)->setProperty("title", "LearnOpenGL-Qt3D");

#ifndef NO_ASSETS
	engine.rootObjects().at(0)->setProperty("qrcOn", true);
#endif

	return app.exec();
}
