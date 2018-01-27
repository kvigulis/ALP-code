#ifndef CHECKPORTSTATE_H
#define CHECKPORTSTATE_H

// Subclass with only purpose to send a periodic signal to check serial port state.

#include <QObject>
#include <QDebug>
#include <QThread>

class CheckPortState : public QObject
{
    Q_OBJECT
public:
    explicit CheckPortState(QObject *parent = 0);
    void doSetup(QThread &cThread);
    bool close = 0;


signals:
    void CheckPortStateTimePassed();
    void aboutToCloseSent();

public slots:
    void doWork();
    void onAboutToQuit();
private:

    void delay(int mS);


};

#endif // CHECKPORTSTATE_H
