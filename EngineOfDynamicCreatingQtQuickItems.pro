TEMPLATE = app

TARGET = EngineOfDynamicCreatingQtQuickItems

QT += qml quick sql multimedia core bluetooth

#PATH =

CONFIG += c++11
CONFIG -= bitcode

SOURCES += main.cpp \

RESOURCES += \
    js.qrc \
    img.qrc \
    qml.qrc \
    qtquickcontrols2.conf

ios {
    QMAKE_INFO_PLIST = $$PWD/info.plist
    ios_icon.files = $$files($$PWD/iconApp/Icon-App-*.png)
    QMAKE_BUNDLE_DATA += ios_icon
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
#sqldrivers.libqsqlite.dylib

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
