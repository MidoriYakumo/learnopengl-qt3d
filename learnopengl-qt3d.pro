QT += qml quick quickcontrols2 3dcore 3drender 3dinput 3dlogic 3dquick 3dquickextras
#sensors charts

CONFIG += c++11

SOURCES += main.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES += qml/*.qml

DISTFILES += shared

# Do not distribute with assets
CONFIG += no_assets
CONFIG += no_app

!contains(CONFIG, no_app) {
	RESOURCES += app.qrc
} else {
	DEFINES += NO_APP_QRC
	message(no_app/qml on)
}

unix:!contains(CONFIG, no_assets) {
	include(assets.pri)
} else {
	DEFINES += NO_ASSETS_QRC
	message(no_assets on)
}
