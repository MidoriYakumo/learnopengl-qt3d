QT += 3dcore 3drender 3dinput 3dquick qml quick quickcontrols2 3dquickextras
#sensors charts

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += app.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES += qml/*.qml

DISTFILES += shared

# Do not distribute with assets
CONFIG += no_assets

unix:!contains(CONFIG, no_assets) {
	include(assets.pri)
} else {
	DEFINES += NO_ASSETS
	message(no_assets on)
}
