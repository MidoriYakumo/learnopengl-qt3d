QT += 3dcore 3drender 3dinput 3dquick qml quick 3dquickextras

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += app.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += qml/*.qml
