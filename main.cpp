#include <QApplication> // QtCharts require QtWidgets QApplication ... interesting
#include <QOpenGLContext>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char* argv[])
{

#ifdef Q_OS_WIN
	QQuickStyle::setStyle("Universal");
#else
	QQuickStyle::setStyle("Material");
#endif

	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling); // Good for QuickControls, bad for canvas items
	QApplication app(argc, argv); // Opengl dynamic module require create app first

	QSurfaceFormat format;
	if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGL) { // Learn OpenGL
		format.setVersion(4, 3);
		format.setProfile(QSurfaceFormat::CoreProfile);
		format.setSamples(4);
	} else if (QOpenGLContext::openGLModuleType() == QOpenGLContext::LibGLES) { // Learn OpenGLES??
		format.setVersion(3, 0);
		format.setSamples(0);
	}
	format.setAlphaBufferSize(0);
	format.setDepthBufferSize(0);
	format.setStencilBufferSize(0);
	format.setSwapBehavior(QSurfaceFormat::TripleBuffer);
	format.setSwapInterval(0); // Full speed rendering

	QSurfaceFormat::setDefaultFormat(format);

	QQmlApplicationEngine engine;
	engine.addImportPath(QLatin1String("qrc:/com/github/midoriyakumo"));

#ifdef NO_APP_QRC
#ifdef Q_OS_ANDROID
	engine.load(QUrl(QLatin1String("file:/sdcard/Documents/QML Projects/Examples/LearnOpenGL/app.qml")));
#else
	engine.load(QUrl(QLatin1String("../qml/app.qml")));
#endif
#else
	engine.load(QUrl(QLatin1String("qrc:/qml/app.qml")));
	engine.rootObjects().at(0)->setProperty("qrcAppOn", true);
#endif

#ifndef NO_ASSETS_QRC
	engine.rootObjects().at(0)->setProperty("qrcAssetsOn", true);
#endif

	engine.rootObjects().at(0)->setProperty("title", "LearnOpenGL-Qt3D");

	return app.exec();
}
