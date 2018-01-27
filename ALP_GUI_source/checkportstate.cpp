#include "checkportstate.h"
#include <QtCore>
#include <QTime>
#include <QDebug>
#include <QThread>

//Class used for loop functionality.

CheckPortState::CheckPortState(QObject *parent) : QObject(parent)
{

}

void CheckPortState::delay(int millisecondsToWait )
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime )
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
}


void CheckPortState::doSetup(QThread &cThread){
    connect(&cThread, SIGNAL(started()), this, SLOT(doWork()));
}

void CheckPortState::doWork()
{
    while(!close)
    {
        QMutex mutex;
        mutex.lock();
        if(this->close) break;
        mutex.unlock();

        emit CheckPortStateTimePassed();
        delay(200);
    }
}

void CheckPortState::onAboutToQuit()
{
    qDebug() << "ABOUT TO CLOSE INITIATED ----------------------- Bye!";
    close = 1;

}




