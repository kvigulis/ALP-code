#ifndef STARTSEQUENCETHREAD_H
#define STARTSEQUENCETHREAD_H

#include <QObject>
#include <QDebug>
#include <QThread>


class StartSequenceThread : public QObject
{
    Q_OBJECT
public:
    explicit StartSequenceThread(QObject *parent = 0);
    void doSetup(QThread &cThread);
    bool close = 0;

public slots:
    void doWork();

private:
    void delay(int mS);

};

#endif // STARTSEQUENCETHREAD_H
