#ifndef TCPSOCKET_H
#define TCPSOCKET_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractSocket>
#include <QDebug>

class GuiSocket : public QObject
{
    Q_OBJECT
public:
    explicit GuiSocket (QObject *parent = 0);
    void Connect(QString IP);
    void Disconnect();
    void ethernetWrite(QByteArray command);

signals:
    void readReadyEmitted();

public slots:

    void Connected();
    void Disconnected();
    int State();

    void bytesWritten(qint64 bytes);
    void readyRead();
    QString returnLine();

private:
    QTcpSocket *socket;
    QTcpSocket *controlSocket;
    char buffer [33];

};

#endif // TCPSOCKET_H
