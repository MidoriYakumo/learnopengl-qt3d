# learnopengl-qt3d

Qt3D version of http://learnopengl.com/ examples, currently works with Qt5.7

**Just want to see how OpenGL works in Qt3D undocumented libs~**

Pure QML version, use qmlscene to run with default OpenGL Context (GLES2.0 compatible)

![](doc/img/ss-qml.png)

Compiled version, context set to GL3.3

![](doc/img/ss-qt3d-desktop.png)

notes
===

Main qml file for qmlscene/binary/QmlCreator

* app.qml: main window with line chart FPS display

* app-cpp.qml: main window with text FPS display

* main.qml: QuickItem as root + text FPS display

You can lauch one sample with a keyword like:

* qmlscene skybox app.qml
* ./learnopengl-qt3d geometry

**Some large assets from the website is downloaded by qmake script(*nix only), connection is required at the first build or after updated. Use CONFIG += no_assets to skip. See assets.pri for details**

**leanopengl uses a little different lighting model from Qt3D default model, to rendering models for a better result, please slightly modify the ka, kd in mtl files**

Examples
===

* [Hello Window](doc/Hello-Window.md) : works
