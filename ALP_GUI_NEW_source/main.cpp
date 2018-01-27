#include <QGuiApplication>
#include <QApplication>
#include <QtCore>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <communication.h>
#include "csvdialog.h"
#include <QDebug>
#include <QUrl>
#include <QObject>
#include <QMainWindow>
#include <QCloseEvent>
#include <QtQuick/QQuickView>




int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication *app = new QApplication(argc, argv);

    QUrl appPath(QString("%1").arg(app->applicationDirPath()));

    qDebug() << "This is where the application lives" << appPath;

    QScopedPointer<Communication> comm (new Communication);
    QScopedPointer<CSVDialog> csv (new CSVDialog);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("comm", comm.data());
    engine.rootContext()->setContextProperty("csv", csv.data());
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app->exec();
}






