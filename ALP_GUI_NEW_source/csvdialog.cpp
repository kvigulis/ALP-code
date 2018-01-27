#include "csvdialog.h"
#include "communication.h"
#include <QWidget>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
#include <QDebug>
#include <QSettings>
#include <QMessageBox>

CSVDialog::CSVDialog(QWidget *parent) : QWidget(parent)
{

}

void CSVDialog::getSettings()
{
    QSettings settings("my");
    settings.beginGroup("csvGroup");
    output1 = settings.value("serialCSV");
    settings.endGroup();
}


void CSVDialog::saveFile()
{
    getSettings();
    //QString mFilename = "C:/Users/Lenovo Z Series/Desktop/QT Training/Serial111.csv";

    QString mFilename = QFileDialog::getSaveFileName(this, tr("Save CSV File", "C:/"), tr(".csv"), "*.csv");
    if(!mFilename.isNull()){  // mFilename will be NULL if user presses CANCEL. Need this statement otherwise it tries to do Write even the CANCEL was pressed.
        qDebug() << "Save file called";
        Write(mFilename);

    }


}


void CSVDialog::Write(QString Filename)
{
    QFile mFile(Filename);

    if(!mFile.open(QFile::WriteOnly | QFile::Text))
    {
        qDebug() << "Could not open file for writting.";
        QMessageBox mbSerialDevicesNotConnected("ALP Power Warrning",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.::! Could not overwrite the CSV file !::.</b>"
                       "<br><br>If the file is already open or being used in some other <br>software please close it or chose a different file name.",
                       QMessageBox::Critical,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbSerialDevicesNotConnected.exec();
        return;
    }

    //qDebug() << output + "<- this is output..";

    QTextStream out(&mFile);

    QString output = output1.toString();
    qDebug () << output;
    out << output;

    mFile.flush();
    mFile.close();
}



