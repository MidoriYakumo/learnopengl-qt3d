QT += 3dcore 3drender 3dinput 3dquick qml quick quickcontrols2 3dquickextras

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += app.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES += qml/*.qml

DISTFILES += \
    shared/shaders/textures_combined.frag \
    shared/shaders/textures_combined.vert \
    qml/transformations.qml \
    shared/shaders/transformations.vert
