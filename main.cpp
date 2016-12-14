#include <QGuiApplication>
#include <QOpenGLContext>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QQuickStyle>

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling); // Good for QuickControls, bad for canvas items
  QGuiApplication app(argc, argv);

  QSurfaceFormat format;
  if (QOpenGLContext::openGLModuleType() ==
	  QOpenGLContext::LibGL) { // Learn OpenGL
	format.setVersion(4, 3);
	format.setProfile(QSurfaceFormat::CoreProfile);
  } else if (QOpenGLContext::openGLModuleType() ==
			 QOpenGLContext::LibGLES) { // Learn OpenGLES??
	format.setVersion(3, 0);
  }

  format.setAlphaBufferSize(0);
  format.setDepthBufferSize(0);
  format.setSamples(4);
  format.setStencilBufferSize(0);
  format.setSwapBehavior(QSurfaceFormat::TripleBuffer);
  format.setSwapInterval(0); // Full speed rendering

  QSurfaceFormat::setDefaultFormat(format);

#ifdef Q_OS_WIN
  QQuickStyle::setStyle("Universal");
#else
  QQuickStyle::setStyle("Material");
#endif

  QQmlApplicationEngine engine;

#ifdef NO_APP_QRC
#ifdef Q_OS_ANDROID
  engine.load(QUrl(QLatin1String("file:/sdcard/Documents/QML Projects/Examples/LearnOpenGL/app-cpp.qml")));
  //engine.load(QUrl(QLatin1String("file:/sdcard/Documents/QML Projects/Examples/LearnOpenGL/app.qml")));
#else
  engine.load(QUrl(QLatin1String("file:../qml/app-cpp.qml")));
  //engine.load(QUrl(QLatin1String("file:../qml/app.qml"))); // QtCharts crashes the program
#endif
#else
  engine.load(QUrl(QLatin1String("qrc:/qml/app-cpp.qml")));
  //engine.load(QUrl(QLatin1String("qrc:/qml/app.qml"))); // QtCharts crashes the program
  engine.rootObjects().at(0)->setProperty("qrcAppOn", true);
#endif

#ifndef NO_ASSETS_QRC
  engine.rootObjects().at(0)->setProperty("qrcAssetsOn", true);
#endif

  engine.rootObjects().at(0)->setProperty("title", "LearnOpenGL-Qt3D");

  return app.exec();
}
