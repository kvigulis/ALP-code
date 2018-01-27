#include "guisocket.h"

GuiSocket::GuiSocket(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
    connect(socket,SIGNAL(connected()),this, SLOT(Connected()));
    connect(socket,SIGNAL(disconnected()),this, SLOT(Disconnected()));
    connect(socket,SIGNAL(readyRead()),this, SLOT(readyRead()));
    connect(socket,SIGNAL(bytesWritten(qint64)),this, SLOT(bytesWritten(qint64)));

}

void GuiSocket::Connect(QString IP)
{    
    if(socket->state() == QTcpSocket::ConnectedState){
        qDebug() << "Connection returned. Already CONNECTED";
        return;
    }
    else{
        socket->connectToHost(IP, 23);
    }

    if(!socket->waitForConnected(200))
    {
        qDebug() << "Error: " << socket->errorString();

    }    

}

void GuiSocket::Disconnect()
{
    socket->close();
}



void GuiSocket::Connected()
{
   qDebug() << "Ethernet device Connected!";
   socket->write("1");
}

void GuiSocket::Disconnected()
{
    qDebug() << "Ethernet device Disconnected!";
}

int GuiSocket::State()
{
    return socket->state();
}

void GuiSocket::ethernetWrite(QByteArray command)
{
    socket->write(command);
}

void GuiSocket::bytesWritten(qint64 bytes)
{
    qDebug() << "We wrote: " << bytes;
}

void GuiSocket::readyRead()
{
    //qDebug() << "Reading... " << socket->bytesAvailable();
    emit readReadyEmitted();
}

QString GuiSocket::returnLine()
{
    QByteArray line = socket->readAll();
    QByteArray formatedLine = line.right(line.length()-2);
    QString strLine = QString::fromStdString(formatedLine.toStdString());
    return strLine;
}
