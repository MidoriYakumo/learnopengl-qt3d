include(qml-virtualkey/com_github_midoriyakumo_qmlvirtualkey.pri)

QT = quick quickcontrols2 charts

CONFIG += c++11

SOURCES += main.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/qml-virtualkey

OTHER_FILES += qml/*.qml

DISTFILES += shared

# Do not distribute with assets
CONFIG += no_assets
#CONFIG += no_app

!contains(CONFIG, no_app) {
	RESOURCES += app.qrc
} else {
	DEFINES += NO_APP_QRC
	message(app.qrc not included.)
}

unix:!contains(CONFIG, no_assets) {
	include(assets.pri)
} else {
	DEFINES += NO_ASSETS_QRC
	message(assets.qrc not included.)
}
