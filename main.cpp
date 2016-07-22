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
	if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGL) {
		format.setVersion(3, 3);
		format.setProfile(QSurfaceFormat::CoreProfile);
	} else if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGLES) {}

	format.setDepthBufferSize(24);
	format.setStencilBufferSize(8);
	format.setSamples(4);

	QSurfaceFormat::setDefaultFormat(format);

	QQuickStyle::setStyle("Material");

	QQmlApplicationEngine engine;
	engine.load(QUrl(QLatin1String("qrc:/qml/app-cpp.qml"))); // if qtcharts crashes the program
// 	engine.load(QUrl(QLatin1String("qrc:/qml/app.qml")));
	engine.rootObjects().at(0)->setProperty("title", "LearnOpenGL-Qt3D");
	engine.rootObjects().at(0)->setProperty("qrcOn", true);

	return app.exec();
}
