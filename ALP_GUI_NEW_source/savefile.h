#ifndef SAVEFILE_H
#define SAVEFILE_H

#include <QWidget>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>

class SaveFile : public QWidget
{
    Q_OBJECT
public:
    explicit SaveFile(QWidget *parent = 0);

    Q_INVOKABLE void saveFile();
    Q_INVOKABLE void clearStream();

    void Write(QString Filename);

signals:

public slots:
};

#endif // SAVEFILE_H
