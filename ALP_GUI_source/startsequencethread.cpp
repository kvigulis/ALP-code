#include "startsequencethread.h"
#include <QtCore>
#include <QTime>
#include <QDebug>
#include <QThread>

StartSequenceThread::StartSequenceThread(QObject *parent) : QObject(parent)
{

}

void StartSequenceThread::doSetup(QThread &cThread){
    connect(&cThread, SIGNAL(started()), this, SLOT(doWork()));
}

void StartSequenceThread::doWork()
{
    while(!close)
    {

        QMutex mutex;
        mutex.lock();
        if(this->close) break;
        mutex.unlock();

        //emit reactorLevelTimePassed();
        //getSettings();

        //reactorLevelLowStableCheck();

        //saveSettings();
        //emit reactorLevelLowStableSent();
        delay(10);

    }
}

void StartSequenceThread::delay(int millisecondsToWait )
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime )
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
}
