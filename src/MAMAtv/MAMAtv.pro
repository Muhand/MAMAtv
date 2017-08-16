QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    fileio.cpp \
    boot.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


# Default rules for deployment.
include(deployment.pri)

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/release/ -lVLCQtCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/debug/ -lVLCQtCore
else:unix: LIBS += -L$$PWD/../../../../../../usr/local/lib/ -lVLCQtCore

INCLUDEPATH += $$PWD/../../../../../../usr/local/include
DEPENDPATH += $$PWD/../../../../../../usr/local/include

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/release/ -lVLCQtQml
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/debug/ -lVLCQtQml
else:unix: LIBS += -L$$PWD/../../../../../../usr/local/lib/ -lVLCQtQml

INCLUDEPATH += $$PWD/../../../../../../usr/local/include
DEPENDPATH += $$PWD/../../../../../../usr/local/include

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/release/ -lVLCQtWidgets
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../../usr/local/lib/debug/ -lVLCQtWidgets
else:unix: LIBS += -L$$PWD/../../../../../../usr/local/lib/ -lVLCQtWidgets -lcurl

INCLUDEPATH += $$PWD/../../../../../../usr/local/include
DEPENDPATH += $$PWD/../../../../../../usr/local/include

DISTFILES += \
    qmldir \
    qmldir

HEADERS += \
    fileio.h \
    boot.h
