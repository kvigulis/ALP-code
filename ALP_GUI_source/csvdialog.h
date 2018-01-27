#ifndef CSVDIALOG_H
#define CSVDIALOG_H

#include "communication.h"
#include <QWidget>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
#include <QDebug>

class CSVDialog : public QWidget
{
    Q_OBJECT
public:
    explicit CSVDialog(QWidget *parent = 0);

    QString output;
    QVariant output1;

    void getSettings();

    Q_INVOKABLE void saveFile();

    void Write(QString Filename);

signals:

public slots:    

};

#endif // CSVDIALOG_H
