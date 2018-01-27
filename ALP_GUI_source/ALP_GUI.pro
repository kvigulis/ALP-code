QT += widgets qml quick serialport
QT += gui

QT += core

QT += network

QT += charts

CONFIG += c++11

CONFIG += qt


SOURCES += main.cpp \
    communication.cpp \
    csvdialog.cpp \
    guisocket.cpp


RESOURCES += qml.qrc \

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    communication.h \
    csvdialog.h \
    guisocket.h



