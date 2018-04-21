TEMPLATE = app

TARGET = EngineOfDynamicCreatingQtQuickItems

QT += qml quick sql

#PATH =

CONFIG += c++11

HEADERS += \
    sql_engine.h \
    mediator.h

SOURCES += main.cpp \
    sql_engine.cpp \
    mediator.cpp

RESOURCES += \
    js.qrc \
    img.qrc \
    qml.qrc

#QT_LOGGING_RULES=qt.network.ssl.warning=false

macx: LIBS += -L$$PWD/../../../../../../../usr/local/Cellar/openssl/1.0.2j/lib/ -lcrypto -lssl
INCLUDEPATH += $$PWD/../../../../../../../usr/local/Cellar/openssl/1.0.2j/include
DEPENDPATH += $$PWD/../../../../../../../usr/local/Cellar/openssl/1.0.2j/include

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
#sqldrivers.libqsqlite.dylib

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
