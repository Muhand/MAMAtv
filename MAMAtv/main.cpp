//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
#include <QtCore/QCoreApplication>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml>            // If you use Qt5

#include <VLCQtCore/Common.h>
#include <VLCQtQml/QmlVideoPlayer.h>
#include<iostream>

#include "fileio.h"    // Your FileIO C++ class
#include "boot.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("MAMATV");
    QCoreApplication::setAttribute(Qt::AA_X11InitThreads);

    qmlRegisterType<FileIo>("MAMAtv", 1, 0, "FileIo");
    qmlRegisterType<Boot>("MAMAtv", 1, 0, "Boot");

    QGuiApplication app(argc, argv);
    VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins");
    VlcQmlVideoPlayer::registerPlugin();

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    QDeclarativeView view;
//    view.setSource(QUrl("qrc:/main.qml"));    // if your QML files are inside
//                                               // application resources

//    view.showFullScreen();    // here we show our view in fullscreen
    QQuickView quickView;
    quickView.setSource(QUrl(QStringLiteral("qrc:/Boot.qml")));
    quickView.setResizeMode(QQuickView::SizeRootObjectToView);
//    quickView.showFullScreen();
    quickView.showMaximized();

    return app.exec();
}
