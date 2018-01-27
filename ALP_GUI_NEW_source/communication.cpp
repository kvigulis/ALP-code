#include "communication.h"
#include <QApplication>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QMessageBox>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
#include <QWidget>
#include <QSettings>
#include <QTime>
#include <QDateTime>
#include <QThread>
#include <terminaldata.h>
#include <guisocket.h>


Communication::Communication(QObject *parent) :
    QObject(parent)
  // Class constructor

{
    arduino_controlbox_is_available = false;
    arduino_sensorbox_is_available = false;
    //arduino_controlbox_port_name = "";
    arduino1 = new QSerialPort;  // Control box Serial port object.
    arduino2 = new QSerialPort;  // Sensor box Serial port object.    
    incomingDataOutput = "";



    ethernetSensorSocket = new GuiSocket;
    ethernetControlSocket = new GuiSocket;

    connect(this, SIGNAL(dataTerminalReadyChanged()), this, SLOT(onCheckPortStateChanged()));

    qDebug() << "Number of available ports: " << QSerialPortInfo::availablePorts().length();    //  Just to check the IDs of the device so that a communication with the right device will be established.
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        qDebug() << "Port ID: " << serialPortInfo.portName();
        qDebug() << "Serial Number" << serialPortInfo.manufacturer();
        qDebug() << "Has vendor ID: " << serialPortInfo.hasVendorIdentifier();
        if(serialPortInfo.hasVendorIdentifier()){
            qDebug() << "Vendor ID: " << serialPortInfo.vendorIdentifier();
        }
        qDebug() << "Has Product ID: " << serialPortInfo.hasProductIdentifier();
        if(serialPortInfo.hasProductIdentifier()){
            qDebug() << "Product ID: " << serialPortInfo.productIdentifier();
        }
    }

}

 // .::Class Member functions::.

void Communication::resetFeedWaitTime()  // For now used only in the funtion 'delayFeedResetSensitive' to exit from it when 'stopFeeding' or 'stopEverythingClicked' is pressed.
{
    resetTimeTrigger = 1;
}

void Communication::delay( int millisecondsToWait ) // Simple delay that will exit only when it's finished.
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime )
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
}

void Communication::delayStopSensitive( int millisecondsToWait )   // Delay exits when f_feedingExecuting turns FASLE (by pressing STOP Feeding button). Used while inside feeding cycle. ( For Author: should be made simpler by using just one delay???)
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime && f_feedingExecuting)
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
    if (!f_feedingExecuting) {
        qDebug() << "^^^^^^^^^^^^^^^^^^^ Stop sensitve time delay exit triggered. ^^^^^^^^^^^^^^^^^^^";
    }
}

void Communication::delayFeedResetSensitive( int millisecondsToWait )   // Currently functions exits identicaly with 'delayStopSensitive', (by pressing STOP Feeding button).
    // But implemente in case auto feed Time gap counter needs be be reset by other means. To do that just call 'resetFeedWaitTime()' function.
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime && !resetTimeTrigger)
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
    if(resetTimeTrigger){
        qDebug() << "^^^^^^^^^^^^^^^^^^^ Reset sensitve time delay triggered. ^^^^^^^^^^^^^^^^^^^";
    }
    resetTimeTrigger = 0;
}

void Communication::saveCsvSettings() // 'QSettings' object used to make the parameter available to all the project's classes. In this case for a class(csvdialog.cpp) that uses QFileDialog, QFile, QTextStream.
{
    QSettings sett("my");
    sett.beginGroup("csvGroup");
    sett.setValue("serialCSV", s_serialOutputCSV_formated);
    sett.endGroup();
}

void Communication::clearStream()  // Clears both unformated data string and also fomratted CSV Excel-ready string  q   `1` `
{
    incomingDataOutput = "";
    s_serialOutputCSV_formated = "Date / Time, T  bottom, T middle, T top, T upper middle, T lid, T exit, T cyclone, T H2O, Flow 1, Flow 2, Pressure, Pellet Level,"
                                 ""
                                 "\n";
}

void Communication::refreshPorts()
{
    QStringList serialPortList;
    serialPortList << "-";
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier())
            serialPortList << serialPortInfo.portName();
    }

    setSerialPortList(serialPortList);

    qDebug() << "Serial Port list: " << serialPortList;
}

void Communication::acceptPortControlBox(int port)
{
    arduino_controlbox_port = serialPortList().at(port);
    qDebug() << "CONTROL box port set to:" << arduino_controlbox_port;
}

void Communication::acceptPortSensorBox(int port)
{
    arduino_sensorbox_port = serialPortList().at(port);
    qDebug() << "SENSOR box port set to:" << arduino_sensorbox_port;
}


void Communication::startSerialCommunication()
{
    incomingDataOutput = "";
    ethernetChoice = false;
    serialChoice = true;
    ethernetSensorSocket->Disconnect();
    ethernetControlSocket->Disconnect();    

    QObject::disconnect(ethernetSensorSocket, SIGNAL(readReadyEmitted()), this, SLOT(readIncomingData()));

    QObject::disconnect(arduino2, SIGNAL(readyRead()), this, SLOT(readIncomingData()));
    arduino_controlbox_is_available = false;
    arduino_sensorbox_is_available = false;

    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier()){
            if(serialPortInfo.portName() == arduino_controlbox_port){
                arduino_controlbox_is_available = true;
            }
            else
            {
                qDebug() << "Problem with finding CONTROL BOX.";
            }
        }
    }

    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier()){
            if(serialPortInfo.portName() == arduino_sensorbox_port){
                arduino_sensorbox_is_available = true;
            }
            else
            {
                qDebug() << "Problem with finding SENSOR BOX.";
            }
        }
    }
    arduino1->close();
    arduino2->close();

    qDebug() << "Both COMS just closed. Can start Communication again.";

    qDebug() << "CONTROL box port as: " << arduino_controlbox_port;
    qDebug() << "SENSOR box port as: " << arduino_sensorbox_port;



    if(arduino_sensorbox_is_available){
        //open and configure the control box serial comm.
        qDebug() << "Found the arduino sensor box port...\n";
        arduino2->setPortName(arduino_sensorbox_port);
        arduino2->open(QSerialPort::ReadOnly); // Use ReadOnly if using with sensor box.
        arduino2->setBaudRate(QSerialPort::Baud9600); // !! Make sure these match with arduino setting.
        arduino2->setDataBits(QSerialPort::Data8);
        arduino2->setParity(QSerialPort::NoParity);
        arduino2->setStopBits(QSerialPort::OneStop);
        arduino2->setFlowControl(QSerialPort::NoFlowControl);
        QObject::connect(arduino2, SIGNAL(readyRead()), this, SLOT(readIncomingData()));

    }else{
        // give error message if not available
        // QMessageBox::warning(this,"PORT ERROR WARRNING!","Control box not connected or not found.");
    }

    if(arduino_controlbox_is_available){
        //open and configure the control box serial comm.
        qDebug() << "Found the arduino control box port...\n";
        arduino1->setPortName(arduino_controlbox_port);
        arduino1->open(QSerialPort::WriteOnly); // Use ReadOnly if using with sensor box.
        arduino1->setBaudRate(QSerialPort::Baud115200); // !! Make sure these match with arduino setting.
        arduino1->setDataBits(QSerialPort::Data8);
        arduino1->setParity(QSerialPort::NoParity);
        arduino1->setStopBits(QSerialPort::OneStop);
        arduino1->setFlowControl(QSerialPort::NoFlowControl);

    }else{
        // give error message if not available
        // QMessageBox::warning(this,"PORT ERROR WARRNING!","Control box not connected or not found.");
    }
}

void Communication::startEthernetCommunication()
{    
    serialChoice = false;
    ethernetChoice = true;
    ethernetSensorSocket->Disconnect();
    ethernetControlSocket->Disconnect();
    qDebug() << "Connecting to Sensor box:" << sernsorIP;
    qDebug() << "And Control box:" << controlIP;
    ethernetSensorSocket->Connect(sernsorIP);
    ethernetControlSocket->Connect(controlIP);


    if(ethernetSensorSocket->State() != QTcpSocket::ConnectedState && ethernetControlSocket->State() != QTcpSocket::ConnectedState){
            QMessageBox mbSensorBoxNotFound("ALP Power Message",
                           "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: No Controllino devices found on the LAN ::.</b>"
                           "<br><br>Check if the Ethernet cables are connected and that there is power for both Controllinos and the Network Switch.",
                           QMessageBox::Warning,
                           QMessageBox::Ok | QMessageBox::Escape,
                           QMessageBox::NoButton,
                           QMessageBox::NoButton);
            mbSensorBoxNotFound.exec();
            return;
    }

    else if(ethernetControlSocket->State() != QTcpSocket::ConnectedState){
        QMessageBox mbControlBoxNotFound("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: The Control Box was not found on the LAN ::.</b>"
                       "<br><br>Check if the Ethernet cable is connected and that there is power.",
                       QMessageBox::Warning,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbControlBoxNotFound.exec();
        return;
    }
    else if(ethernetSensorSocket->State() != QTcpSocket::ConnectedState){
        QMessageBox mbSensorBoxNotFound("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: Sensor Box was not found on the LAN ::.</b>"
                       "<br><br>Check if the Ethernet cable is connected and that there is power.",
                       QMessageBox::Warning,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbSensorBoxNotFound.exec();
        return;
    }

    QObject::disconnect(arduino2, SIGNAL(readyRead()), this, SLOT(readIncomingData()));

    QObject::connect(ethernetSensorSocket, SIGNAL(readReadyEmitted()), this, SLOT(readIncomingData()));
}

void Communication::updateControlBox(QString command)
{
    if(arduino1->isWritable())
    {
        qDebug() << "Command sent";
        arduino1->write(command.toStdString().c_str());
    }
    else
    {
        qDebug() << "Couldn't write to serial";
        setPortStateColorControlBox("#ff1737");
    }
}

void Communication::readIncomingData()
{
    //qDebug() << "incoming data funtion called!!!";
    // This function reads incoming data, updates the sensor values in GUI and makes a CSV formated QString - either from USB/Serial or Ethernet/TCP
    if(serialChoice){
    incomingData = arduino2->readAll();

    incomingDataOutput += QString::fromStdString(incomingData.toStdString());

    int lastDelimiterIndex = incomingDataOutput.lastIndexOf(delimiter); //  This section is used to solve a problem with getting the last complete line reading. You don't always get a valid line (right number of CSVs) on every incoming serial read.
    int beforeLastDelimiterIndex = incomingDataOutput.lastIndexOf(delimiter,lastDelimiterIndex-1);
    int distanceBetweenDelimiters = lastDelimiterIndex - beforeLastDelimiterIndex;
    lastCompleteLine = incomingDataOutput.mid(beforeLastDelimiterIndex + 3, distanceBetweenDelimiters-2);
    }
    if(ethernetChoice){
    lastCompleteLine = ethernetSensorSocket->returnLine();    
    }

    QStringList bufferSplit = lastCompleteLine.split("+");
    //qDebug() << "lastCompleteLine:  " << lastCompleteLine;

    if(bufferSplit.length() == 12){ // 8 Temperatures, 2 Flows, 1 Pressure, 1 Reactor Level.   Update only up to the last valid line with right amount of CSVs.

        incomingLineCounter += 1;
        settempValue1(bufferSplit[0]);  // T bottom
        settempValue2(bufferSplit[1]);  // T mid
        settempValue3(bufferSplit[2]);  // T top
        settempValue4(bufferSplit[3]);  // T upper mid
        settempValue5(bufferSplit[4]);  // T lid
        settempValue6(bufferSplit[5]);  // T exit
        settempValue7(bufferSplit[6]);  // T cyclone
        settempValue8(bufferSplit[7]);  // T H2O
        settempWater1(bufferSplit[8]);
        setflowValue1(bufferSplit[9]);
        setflowValue2(bufferSplit[10]);
        setpressureValue1(bufferSplit[11]);
        r_level = bufferSplit[12].toDouble();
        setReactorLevelState(r_level);

        if(incomingLineCounter == 10) // Every tenth serial read to CSV output
        {
            QDateTime currentDateTime = QDateTime::currentDateTime();

            QString currentDateTimeString = currentDateTime.toString(dateTimeFormat);

            s_serialOutputCSV_formated += currentDateTimeString + ",     " + lastCompleteLine.replace(QString("+"), QString(",      ")) + "\n";

            setSerialOutputCSV_formated(s_serialOutputCSV_formated);

            saveCsvSettings(); // Saves QString serialOutput as setting so it is available to other C++ classes of the GUI

            incomingLineCounter = 0;
        }


    }

    else {
        qDebug() << "Faulty line: " << lastCompleteLine;
        qDebug() << "!!!!!!!!!!!!!!!!!!!!!!   Sensor information error. Not a list of 12 elements.   !!!!!!!!!!!!!!!!!!!!!!!!!!";
        return;

        if(!firstTimeWrongLine){
            QMessageBox mbControlBoxNotFound("ALP Power Message",
                           "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: The number of Sensor Element in the line received from Controllino does not math the expected ::.</b>",
                           QMessageBox::Warning,
                           QMessageBox::Ok | QMessageBox::Escape,
                           QMessageBox::NoButton,
                           QMessageBox::NoButton);
            firstTimeWrongLine = true;
        }
    }

                // ..Following - Update conditions for Start Sequence on every incoming serial line:


    if(bufferSplit[5].toInt() > t_tempExitTrigger){  // T Exit High enough for flare to be turned on
        t_exitFlareTriggerHigh = 1;
    }
    else
    {
        t_exitFlareTriggerHigh = 0;
    }

    if(bufferSplit[1].toInt() > t_tempMiddleGlowTrigger){
        t_middleGlowTriggerHigh = 1;
    }
    else
    {
        t_middleGlowTriggerHigh = 0;
    }

    if(bufferSplit[7].toInt() > t_tempFansOnTrigger){
        t_h2oFansTriggerHigh = 1;
    }
    else
    {
        t_h2oFansTriggerHigh = 0;
    }

    if(!r_reactorLevelState){
      r_reactorLowCounter = r_reactorLowCounter + 1;
    }
    else
    {
        r_reactorLowCounter = 0;
    }

    // qDebug() << "Reactor level LOW counter: " << r_reactorLowCounter;  ===== DEBUG COMMENT

    if(r_reactorLowCounter > 5)
    {
        reactorLevelLowStable = 1;
    }
    else
    {
        reactorLevelLowStable = 0;
    }

    // Add stepper on

    if(startSequenceExecuting()){
        startSequenceUpdateState();
    }

}

void Communication::startButtonClicked()
{    
    if(     (!serialChoice && !ethernetChoice) ||
            (serialChoice && ( !arduino1->isDataTerminalReady() || !arduino2->isDataTerminalReady() )) ||  // If Serial check in both boxes are connected.
            (ethernetChoice && ((ethernetSensorSocket->State() != QTcpSocket::ConnectedState) || (ethernetControlSocket->State() != QTcpSocket::ConnectedState)))  // If Ethernet check in both boxes are connected.
             )
    {
        QMessageBox mbSerialDevicesNotConnected("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: The necessary Ethernet or Serial Devices are not connected or ready ::.</b>"
                       "<br><br>If using Ethernet: In order to start please make sure that the data is updating. [Check if ethernet cables are connected and that both boxes have power.]"
                       "<br><br>If using Serial: In order to start please make sure both Control Box and Sensor Box in top left are highlighted in green color.",
                       QMessageBox::Warning,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbSerialDevicesNotConnected.exec();
        return;
    }
    else{
        QMessageBox mbQuestion("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: Important Questions ::.</b>"
                       "<br><br>Are the AIR and GAS exit valves open enough?"
                       "<br><br>Is the AIR blower VFD on and set to the desired Hz?"
                       "<br><br>Is the Grate VFD on and working?<br>"
                       "<br>If yes for all the questions Click <b>YES</b> to <b>START</b>.",
                       QMessageBox::Question,
                       QMessageBox::Yes | QMessageBox::Default,
                       QMessageBox::No | QMessageBox::Escape,
                       QMessageBox::NoButton);


        if (mbQuestion.exec() == QMessageBox::No) {
            return;
        }
        else{
            qDebug() << "Start sequence initiated...";
            startSequenceBeginTime = QTime::currentTime();
            setIsBottomValveSwitchOn(f_false);
            setIsWaterSwitchOn(t_true);
            setIsIgnitionSwitchOn(t_true);
            setStartSequenceExecutingState(t_true);
        }
    }
}

void Communication::startSequenceUpdateState()
{
    if((c_checkboxFlareOnTempState && t_exitFlareTriggerHigh) || (c_checkboxFlareOnTimeState && ((startSequenceBeginTime.elapsed()) > t_timeFlareOnTrigger*1000))){
        setIsFlareIgnitionSwitchOn(t_true);   // Flare ON
    }
    if((c_checkboxGlowOffTempState && t_middleGlowTriggerHigh) || (c_checkboxGlowOffTimeState && ((startSequenceBeginTime.elapsed()) > t_timeGlowOffTrigger*1000))){
        setIsIgnitionSwitchOn(f_false);   // Glow plugs OFF
    }
    if(c_checkboxFansOnTempState && t_h2oFansTriggerHigh){
        setIsFansSwitchOn(t_true);   // Fans ON
    }
}

void Communication::stopEverythingClicked()
{
    qDebug() << "!!! STOP Everything Clicked !!!";

    QMessageBox mbQuestion("ALP Power Alert",
                   "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: STOP EVERYTHING ::.</b>"
                   "<br><br>You are about to stop reactor."
                   "<br><br>H<sub>2</sub>O Pump and cooling FANS will stay unchanged."
                   "<br><br>(For processes that relay on time counting, their times will be reset)"
                   "<br><br>Do you want to continue?",
                   QMessageBox::Question,
                   QMessageBox::Yes | QMessageBox::Default,
                   QMessageBox::No | QMessageBox::Escape,
                   QMessageBox::NoButton);


    if (mbQuestion.exec() == QMessageBox::No) {
        return;
    }
    else{
        qDebug() << "!!! STOP Everything done !!!";
        resetFeedWaitTime();
        setFeedingExecutingState(f_false);

        setIsVacuumSwitchOn(f_false);
        setIsRotaryValveSwitchOn(f_false);
        setIsIgnitionSwitchOn(f_false);
        setIsFlareIgnitionSwitchOn(f_false);

        setStartSequenceExecutingState(f_false); // Stop calling 'startSequenceUpdateState()' on incoming serial lines.

    }
}


void Communication::stopFeeding()
{
    qDebug() << "!!! STOP Feeding Called !!!";
    setIsBottomValveSwitchOn(f_false);
    setIsRotaryValveSwitchOn(f_false);
    setFeedingExecutingState(f_false);
    resetFeedWaitTime();    
}


void Communication::feedPellets(double mass)
{

}

/*{
    setFeedingExecutingState(t_true);    

    if(!f_feedingExecuting){
        qDebug() << "******************************* FEED PELLETS function returned *********************************";
        return;
    }
    setIsRotaryValveSwitchOn(t_true);
    double time = mass * 6 * 1000;
    delayStopSensitive(time);
    if(!f_feedingExecuting){
        qDebug() << "******************************* FEED PELLETS function returned *********************************";
        return;
    }
    setIsRotaryValveSwitchOn(f_false);

    if(!continuousFeed()){
        delayStopSensitive(500);
        if(!f_feedingExecuting){
            qDebug() << "******************************* FEED PELLETS function returned *********************************";
            return;
        }

        setIsBottomValveSwitchOn(f_false);
        delayStopSensitive(16000);
        if(!f_feedingExecuting){
            qDebug() << "******************************* FEED PELLETS function returned *********************************";
            return;
        }
    }
    qDebug() << "Feeding Cycle Done.";

    setFeedingExecutingState(f_false);

}*/

void Communication::onCheckPortStateChanged()
{

    return;
    // Uses the periodic SIGNAL from the parallel thread to constantly check if Serial Connections are ready and OK to use.
    // Also repeatedly calls the 'automaticFeeding(a_autoFeedMass, a_autoFeedTime)' funtion which executes if it's if statments are satisfied.
    if(arduino1->isDataTerminalReady())
    {
        setPortStateColorControlBox("#00ff33");
    }
    else
    {
        setPortStateColorControlBox("#dd0013");
        QMessageBox mbControlBoxNotConnected("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: Control Box not Connected ::.</b>"
                       "<br><br>Control Box not Connected.",
                       QMessageBox::Warning,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbControlBoxNotConnected.exec();
        return;
    }

    if(arduino2->isDataTerminalReady())
    {
        setPortStateColorSensorBox("#00ff33");
    }
    else
    {
        setPortStateColorSensorBox("#dd0013");
        QMessageBox mbSensorBoxNotConnected("ALP Power Message",
                       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>.:: Sensor Box not Connected ::.</b>"
                       "<br><br>Sensor Box not Connected.",
                       QMessageBox::Warning,
                       QMessageBox::Ok | QMessageBox::Escape,
                       QMessageBox::NoButton,
                       QMessageBox::NoButton);
        mbSensorBoxNotConnected.exec();
        return;
    }
}

void Communication::automaticFeeding(double mass, int time)
{


}

void Communication::topValveSwitchPressed(int topValveSwitchState)
{
    qDebug() << "Top Valve (X0) state" << topValveSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 0 %1").arg(topValveSwitchState));   // Send X 1 True/False
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 0 ").append(QByteArray::number(topValveSwitchState,10)).append("!"));   // Send X 1 True/False
    }
}

void Communication::bottomValveSwitchPressed(int bottomValveSwitchState)
{
    qDebug() << "Bottom Valve (X1) state" << bottomValveSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 1 %1").arg(bottomValveSwitchState));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 1 ").append(QByteArray::number(bottomValveSwitchState,10)).append("!"));
    }

}

void Communication::vacuumSwitchPressed(int vacuumSwitchState)
{
    qDebug() << "Vacuum (X2) state" << vacuumSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 2 %1").arg(vacuumSwitchState));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 2 ").append(QByteArray::number(vacuumSwitchState,10)).append("!"));
    }
}

void Communication::rotaryValveSwitchPressed(int speed, QString dir)
{
    qDebug() << "Stepper motor speed:" << speed << "Direction" << dir ;
    qDebug() << "";
    if(serialChoice){
    Communication::updateControlBox(QString("S S %1 %2").arg(dir).arg(speed));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("S S ").append(QByteArray::fromStdString(dir.toStdString())).append(" ").append(QByteArray::number(speed,10)).append("!"));
    }
}


void Communication::ignitionSwitchPressed(int ignitionSwitchState)
{
    qDebug() << "Ignition (X3) state" << ignitionSwitchState;
    if(serialChoice){
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 3 ").append(QByteArray::number(ignitionSwitchState,10)).append("!"));
    }
}

void Communication::flareIgnitionSwitchPressed(int flareIgnitionSwitchState)
{
    qDebug() << "Flare Ignition (X4) state" << flareIgnitionSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 4 %1").arg(flareIgnitionSwitchState));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 4 ").append(QByteArray::number(flareIgnitionSwitchState,10)).append("!"));
    }
}

void Communication::waterSwitchPressed(int waterSwitchState)
{
    qDebug() << "Water Pump (X5) state" << waterSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 5 %1").arg(waterSwitchState));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 5 ").append(QByteArray::number(waterSwitchState,10)).append("!"));
    }
}

void Communication::fansSwitchPressed(int fansSwitchState)
{
    qDebug() << "FANS (X6) state" << fansSwitchState;
    if(serialChoice){
    Communication::updateControlBox(QString("X 6 %1").arg(fansSwitchState));
    }
    if(ethernetChoice){
    ethernetControlSocket->ethernetWrite(QByteArray("X 6 ").append(QByteArray::number(fansSwitchState,10)).append("!"));
    }
}















