#ifndef COMMUNICATION_H
#define COMMUNICATION_H

#include <QObject>
#include <QDebug>
#include <QPoint>
#include <QString>
#include <QSerialPort>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
#include <QWidget>
#include <QTime>
#include <guisocket.h>


class Communication : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList serialPortList READ serialPortList() WRITE setSerialPortList NOTIFY serialPortListChanged)
    Q_PROPERTY(QString portStateColorControlBox READ portStateColorControlBox() WRITE setPortStateColorControlBox NOTIFY portStateColorControlBoxChanged)
    Q_PROPERTY(QString portStateColorSensorBox READ portStateColorSensorBox() WRITE setPortStateColorSensorBox NOTIFY portStateColorSensorBoxChanged)


    // K type - 8 sensors:
    Q_PROPERTY(QString tempValue1 READ tempValue1() WRITE settempValue1 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue2 READ tempValue2() WRITE settempValue2 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue3 READ tempValue3() WRITE settempValue3 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue4 READ tempValue4() WRITE settempValue4 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue5 READ tempValue5() WRITE settempValue5 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue6 READ tempValue6() WRITE settempValue6 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue7 READ tempValue7() WRITE settempValue7 NOTIFY tempChanged)
    Q_PROPERTY(QString tempValue8 READ tempValue8() WRITE settempValue8 NOTIFY tempChanged)

    // Water temperature sensors:
    Q_PROPERTY(QString tempWater1 READ tempWater1() WRITE settempWater1 NOTIFY tempChanged)

    Q_PROPERTY(QString flowValue1 READ flowValue1() WRITE setflowValue1 NOTIFY flowChanged)
    Q_PROPERTY(QString flowValue2 READ flowValue2() WRITE setflowValue2 NOTIFY flowChanged)

    Q_PROPERTY(QString pressureValue1 READ pressureValue1() WRITE setpressureValue1 NOTIFY pressureChanged)

    Q_PROPERTY(bool reactorLevelState READ reactorLevelState() WRITE setReactorLevelState NOTIFY reactorLevelChanged)

    Q_PROPERTY(bool startSequenceExecuting READ startSequenceExecuting() WRITE setStartSequenceExecutingState NOTIFY startSequenceExecutingStateChanged)
    Q_PROPERTY(bool checkboxFlareOnTempState READ checkboxFlareOnTempState() WRITE setCheckboxFlareOnTempState NOTIFY checkboxFlareOnTempStateChanged)
    Q_PROPERTY(bool checkboxFlareOnTimeState READ checkboxFlareOnTimeState() WRITE setCheckboxFlareOnTimeState NOTIFY checkboxFlareOnTimeStateChanged)
    Q_PROPERTY(bool checkboxGlowOffTempState READ checkboxGlowOffTempState() WRITE setCheckboxGlowOffTempState NOTIFY checkboxGlowOffTempStateChanged)
    Q_PROPERTY(bool checkboxGlowOffTimeState READ checkboxGlowOffTimeState() WRITE setCheckboxGlowOffTimeState NOTIFY checkboxGlowOffTimeStateChanged)
    Q_PROPERTY(bool checkboxFansOnTempState READ checkboxFansOnTempState() WRITE setCheckboxFansOnTempState NOTIFY checkboxFansOnTempStateChanged)



    Q_PROPERTY(bool feedingExecuting READ feedingExecuting() WRITE setFeedingExecutingState NOTIFY feedingExecutingStateChanged)
    Q_PROPERTY(int stepperSpeed READ stepperSpeed() WRITE setStepperSpeed  NOTIFY stepperSpeedChanged)
    Q_PROPERTY(QString stepperDirection READ stepperDirection() WRITE setStepperDirection  NOTIFY stepperDirectionChanged)
    Q_PROPERTY(bool autoFeedCheckState READ autoFeedCheckState() WRITE setAutoFeedCheckState  NOTIFY autoFeedCheckStateChanged)

    //Q_PROPERTY(bool continuousFeed READ continuousFeed() WRITE setContinuousFeed  NOTIFY continuousFeedChanged)

    Q_PROPERTY(bool isTopValveSwitchOn READ isTopValveSwitchOn() WRITE setIsTopValveSwitchOn NOTIFY isTopValveSwitchOnChanged) // Used to change button state by an inner call of the program, e.g. auto feed.
    Q_PROPERTY(bool isBottomValveSwitchOn READ isBottomValveSwitchOn() WRITE setIsBottomValveSwitchOn NOTIFY isBottomValveSwitchOnChanged)
    Q_PROPERTY(bool isVacuumSwitchOn READ isVacuumSwitchOn() WRITE setIsVacuumSwitchOn NOTIFY isVacuumSwitchOnChanged)
    Q_PROPERTY(bool isRotaryValveSwitchOn READ isRotaryValveSwitchOn() WRITE setIsRotaryValveSwitchOn NOTIFY isRotaryValveSwitchOnChanged)

    Q_PROPERTY(bool isIgnitionSwitchOn READ isIgnitionSwitchOn() WRITE setIsIgnitionSwitchOn NOTIFY isIgnitionSwitchOnChanged)
    Q_PROPERTY(bool isFlareIgnitionSwitchOn READ isFlareIgnitionSwitchOn() WRITE setIsFlareIgnitionSwitchOn NOTIFY isFlareIgnitionSwitchOnChanged)
    Q_PROPERTY(bool isWaterSwitchOn READ isWaterSwitchOn() WRITE setIsWaterSwitchOn NOTIFY isWaterSwitchOnChanged)
    Q_PROPERTY(bool isFansSwitchOn READ isFansSwitchOn() WRITE setIsFansSwitchOn NOTIFY isFansSwitchOnChanged)

    Q_PROPERTY(int tempExitTrigger READ tempExitTrigger() WRITE setTempExitTrigger NOTIFY tempExitTriggerChanged)
    Q_PROPERTY(int timeFlareOnTrigger READ timeFlareOnTrigger() WRITE setTimeFlareOnTrigger NOTIFY timeFlareOnTriggerChanged)
    Q_PROPERTY(int tempMiddleTrigger READ tempMiddleTrigger() WRITE setTempMiddleTrigger NOTIFY tempMiddleTriggerChanged)
    Q_PROPERTY(int timeGlowOffTrigger READ timeGlowOffTrigger() WRITE setTimeGlowOffTrigger NOTIFY timeGlowOffTriggerChanged)
    Q_PROPERTY(int tempFansOnTrigger READ tempFansOnTrigger() WRITE setTempFansOnTrigger NOTIFY tempFansOnTriggerChanged)

    Q_PROPERTY(QString serialOutputCSV_formated READ serialOutputCSV_formated() WRITE setSerialOutputCSV_formated NOTIFY serialOutputCSV_formatedChanged)





public:
    explicit Communication(QObject *parent = 0);    

    Q_INVOKABLE void clearStream();

    Q_INVOKABLE void startButtonClicked();
    Q_INVOKABLE void stopEverythingClicked();


    Q_INVOKABLE void stopFeeding();
    Q_INVOKABLE void feedPellets(double mass);    
    //Q_INVOKABLE void setStepperSpeed(int speed);
    //Q_INVOKABLE void setStepperDirection(char dir);


    Q_INVOKABLE void refreshPorts();
    Q_INVOKABLE void startSerialCommunication();
    Q_INVOKABLE void startEthernetCommunication();
    Q_INVOKABLE void acceptPortControlBox(int port);
    Q_INVOKABLE void acceptPortSensorBox(int port);


    Q_INVOKABLE void topValveSwitchPressed(int topValveSwitchState);
    Q_INVOKABLE void bottomValveSwitchPressed(int bottomValveSwitchState);
    Q_INVOKABLE void vacuumSwitchPressed(int vacuumSwitchState);
    Q_INVOKABLE void rotaryValveSwitchPressed(int stepSpeed, QString stepDir);


    Q_INVOKABLE void ignitionSwitchPressed(int ignitionSwitchState);
    Q_INVOKABLE void flareIgnitionSwitchPressed(int flareIgnitionSwitchState);
    Q_INVOKABLE void waterSwitchPressed(int waterSwitchState);
    Q_INVOKABLE void fansSwitchPressed(int fansSwitchState);


    void saveCsvSettings();

    void saveStartingAutomationSettings();

    void delay(int mS);

    void delayStopSensitive(int mS);

    void delayFeedResetSensitive(int mS);

    void resetFeedWaitTime();

    QTime startSequenceBeginTime = QTime::currentTime();

    QString incomingDataOutput;
    int incomingLineCounter = 0;
    QString s_serialOutputCSV_formated = "Date / Time\t\t      , T  bottom, T middle  , T top,    T upper middle, T lid     , T exit   , T cyclone   , T H2O      , Flow 1    , Flow 2  , Pressure, Pellet Level"
                                         ""
                                         "\n";

    // === Serial Ports

    void setSerialPortList(const QStringList &s){
        if(s != s_serialPortList){
            s_serialPortList  = s;
            emit serialPortListChanged();
        }
    }

    QStringList serialPortList()
    {
        return s_serialPortList;
    }


    void setPortStateColorControlBox(const QString &c){
        if(c != c_portStateColorControlBox){
            c_portStateColorControlBox  = c;
            emit portStateColorControlBoxChanged();
        }
    }

    QString portStateColorControlBox()
    {
        return c_portStateColorControlBox;
    }

    void setPortStateColorSensorBox(const QString &c){
        if(c != c_portStateColorSensorBox){
            c_portStateColorSensorBox  = c;
            emit portStateColorSensorBoxChanged();
        }
    }

    QString portStateColorSensorBox()
    {
        return c_portStateColorSensorBox;
    }


    void setSerialOutputCSV_formated(const QString &s) {

        s_serialOutputCSV_formated = s;
        qDebug() << "setSerial CSV function called";
        emit serialOutputCSV_formatedChanged();

    }

    QString serialOutputCSV_formated() const {
        return s_serialOutputCSV_formated;
    }

    // === START SEQUENCE CheckBox Settings:

    void setStartSequenceExecutingState(const bool &s) {
        if (s != s_startSequenceExecuting) {
            s_startSequenceExecuting = s;
            emit startSequenceExecutingStateChanged();
        }
    }

    bool startSequenceExecuting() const {
        return s_startSequenceExecuting;
    }


    void setCheckboxFlareOnTempState(bool state)
    {
        c_checkboxFlareOnTempState = state;
        emit checkboxFlareOnTempStateChanged();
    }

    bool checkboxFlareOnTempState() const {
        return c_checkboxFlareOnTempState;
    }

    void setCheckboxFlareOnTimeState(bool state)
    {
        c_checkboxFlareOnTimeState = state;
        emit checkboxFlareOnTimeStateChanged();
    }

    bool checkboxFlareOnTimeState() const {
        return c_checkboxFlareOnTimeState;
    }

    void setCheckboxGlowOffTempState(bool state)
    {
        c_checkboxGlowOffTempState = state;
        emit checkboxGlowOffTempStateChanged();
    }

    bool checkboxGlowOffTempState() const {
        return c_checkboxGlowOffTempState;
    }

    void setCheckboxGlowOffTimeState(bool state)
    {
        c_checkboxGlowOffTimeState = state;
        emit checkboxGlowOffTimeStateChanged();
    }

    bool checkboxGlowOffTimeState() const {
        return c_checkboxGlowOffTimeState;
    }

    void setCheckboxFansOnTempState(bool state)
    {
        c_checkboxFansOnTempState = state;
        emit checkboxFansOnTempStateChanged();
    }

    bool checkboxFansOnTempState() const {
        return c_checkboxFansOnTempState;
    }

    // ===== START SEQUENCE Trigger Settings (Temps & Times)

    void setTempExitTrigger(int &t) {
        if (t != t_tempExitTrigger){
            t_tempExitTrigger = t;
            qDebug() << "T exit Flare trigger set to: " << t << "C";
            emit tempExitTriggerChanged();
        }
    }

    int tempExitTrigger() const {
        return t_tempExitTrigger;
    }

    void setTimeFlareOnTrigger(int &t) {
        if (t != t_timeFlareOnTrigger){
            t_timeFlareOnTrigger = t;
            qDebug() << "Flare ON trigger Time set to: " << t << "Seconds";
            emit timeFlareOnTriggerChanged();
        }
    }

    int timeFlareOnTrigger() const {
        return t_timeFlareOnTrigger;
    }

    void setTempMiddleTrigger(int &t) {
        if (t != t_tempMiddleGlowTrigger){
            t_tempMiddleGlowTrigger = t;
            qDebug() << "T middle Glow plugs OFF trigger set to: " << t << "C";
            emit tempMiddleTriggerChanged();
        }
    }

    int tempMiddleTrigger() const {
        return t_tempMiddleGlowTrigger;
    }

    void setTimeGlowOffTrigger(int &t) {
        if (t != t_timeGlowOffTrigger){
            t_timeGlowOffTrigger = t;
            qDebug() << "Glow plugs OFF time trigger set to: " << t << "Seconds";
            emit timeGlowOffTriggerChanged();
        }
    }

    int timeGlowOffTrigger() const {
        return t_timeGlowOffTrigger;
    }

    void setTempFansOnTrigger(int &t) {
        if (t != t_tempFansOnTrigger){
            t_tempFansOnTrigger = t;
            qDebug() << "T H2O Fans ON trigger set to: " << t << "C";
            emit tempFansOnTriggerChanged();
        }
    }

    int tempFansOnTrigger() const {
        return t_tempFansOnTrigger;
    }

    // ==== Stepper Speed

    void setStepperSpeed(int &s) {
        if (s != s_stepperSpeed){
            s_stepperSpeed = s;
            qDebug() << "Stepper speed set to: " << s << "Hz";            
            emit stepperSpeedChanged();
        }
    }

    int stepperSpeed() const {
        return s_stepperSpeed;
    }

    void setStepperDirection(QString &dir) {
        if (dir != s_stepperDirection){
            s_stepperDirection = dir;
            qDebug() << "Stepper direction set to: " << dir;
            emit stepperSpeedChanged();
        }
    }

    QString stepperDirection() const {
        return s_stepperDirection;
    }

    /*void setContinuousFeed(bool state)
    {
        if (state != c_continuousFeed){
            c_continuousFeed = state;
            qDebug() << "Just rotary when autofeeeding: " << state;
            emit continuousFeedChanged();
        }
    }

    bool continuousFeed() const {
        return c_continuousFeed;
    }*/

    // ==== Feeding and Auto Feeding:

    void setAutoFeedCheckState(bool state)
    {
            a_autoFeedCheckState = state;
            emit autoFeedCheckStateChanged();
    }

    bool autoFeedCheckState() const {
        return a_autoFeedCheckState;
    }

    void setFeedingExecutingState(const bool &f) {
        if (f != f_feedingExecuting) {
            f_feedingExecuting = f;
            emit feedingExecutingStateChanged();
        }
    }

    bool feedingExecuting() const {
        return f_feedingExecuting;
    }


    // ==== CONTROL SWITCHES:

    void setIsTopValveSwitchOn(const bool &i) {
        i_isTopValveSwitchOn = i;
        emit isTopValveSwitchOnChanged();
    }

    bool isTopValveSwitchOn() const {
        return i_isTopValveSwitchOn;
    }

    void setIsBottomValveSwitchOn(const bool &i) {
        i_isBottomValveSwitchOn = i;
        emit isBottomValveSwitchOnChanged();
    }

    bool isBottomValveSwitchOn() const {
        return i_isBottomValveSwitchOn;
    }

    void setIsVacuumSwitchOn(const bool &i) {
        i_isVacuumSwitchOn = i;
        emit isVacuumSwitchOnChanged();
    }

    bool isVacuumSwitchOn() const {
        return i_isVacuumSwitchOn;
    }

    void setIsRotaryValveSwitchOn(const bool &i) {
        i_isRotaryValveSwitchOn = i;
        emit isRotaryValveSwitchOnChanged();
    }

    bool isRotaryValveSwitchOn() const {
        return i_isRotaryValveSwitchOn;
    }

    void setIsIgnitionSwitchOn(const bool &i) {
        i_isIgnitionSwitchOn = i;
        emit isIgnitionSwitchOnChanged();
    }

    bool isIgnitionSwitchOn() const {
        return i_isIgnitionSwitchOn;
    }

    void setIsFlareIgnitionSwitchOn(const bool &i) {
        i_isFlareIgnitionSwitchOn = i;
        emit isFlareIgnitionSwitchOnChanged();
    }

    bool isFlareIgnitionSwitchOn() const {
        return i_isFlareIgnitionSwitchOn;
    }

    void setIsWaterSwitchOn(const bool &i) {
        i_isWaterSwitchOn = i;
        qDebug() << "Water switch on";
        emit isWaterSwitchOnChanged();
    }

    bool isWaterSwitchOn() const {
        return i_isWaterSwitchOn;
    }

    void setIsFansSwitchOn(const bool &i) {
        i_isFansSwitchOn = i;
        emit isFansSwitchOnChanged();
    }

    bool isFansSwitchOn() const {
        return i_isFansSwitchOn;
    }

    // === Sensor Values (Temps, Flows, Pressures, Pellet Levels, ect.)

    void settempValue1(const QString &t) {
        if (t != t_tempValue1) {
            t_tempValue1 = t;
            emit tempChanged();
        }
    }

    QString tempValue1() const {
        return t_tempValue1;
    }

    void settempValue2(const QString &t) {
        if (t != t_tempValue2) {
            t_tempValue2 = t;
            emit tempChanged();
        }
    }

    QString tempValue2() const {
        return t_tempValue2;
    }

    void settempValue3(const QString &t) {
        if (t != t_tempValue3) {
            t_tempValue3 = t;
            emit tempChanged();
        }
    }

    QString tempValue3() const {
        return t_tempValue3;
    }

    void settempValue4(const QString &t) {
        if (t != t_tempValue4) {
            t_tempValue4 = t;
            emit tempChanged();
        }
    }

    QString tempValue4() const {
        return t_tempValue4;
    }

    void settempValue5(const QString &t) {
        if (t != t_tempValue5) {
            t_tempValue5 = t;
            emit tempChanged();
        }
    }

    QString tempValue5() const {
        return t_tempValue5;
    }

    void settempValue6(const QString &t) {
        if (t != t_tempValue6) {
            t_tempValue6 = t;
            emit tempChanged();
        }
    }

    QString tempValue6() const {
        return t_tempValue6;
    }

    void settempValue7(const QString &t) {
        if (t != t_tempValue7) {
            t_tempValue7 = t;
            emit tempChanged();
        }
    }

    QString tempValue7() const {
        return t_tempValue7;
    }

    void settempValue8(const QString &t) {
        if (t != t_tempValue8) {
            t_tempValue8 = t;
            emit tempChanged();
        }
    }

    QString tempValue8() const {
        return t_tempValue8;
    }

    // Water Sensors:

    void settempWater1(const QString &t) {
        if (t != t_tempWater1) {
            t_tempWater1 = t;
            emit tempChanged();
        }
    }

    QString tempWater1() const {
        return t_tempWater1;
    }


    void setflowValue1(const QString &f) {
        if (f != f_flowValue1) {
            f_flowValue1 = f;
            emit flowChanged();
        }
    }
    QString flowValue1() const {
        return f_flowValue1;
    }

    void setflowValue2(const QString &f) {
        if (f != f_flowValue2) {
            f_flowValue2 = f;
            emit flowChanged();
        }
    }
    QString flowValue2() const {
        return f_flowValue2;
    }

    void setpressureValue1(const QString &p) {
        if (p != p_pressureValue1) {
            p_pressureValue1 = p;
            emit pressureChanged();
        }
    }
    QString pressureValue1() const {
        return p_pressureValue1;
    }


    void setReactorLevelState(bool &r) {
        if (r != r_reactorLevelState) {
            r_reactorLevelState = r;
            emit reactorLevelChanged();
        }
    }
    bool reactorLevelState() const {
        return r_reactorLevelState;
    }


signals:

    void tempChanged();
    void flowChanged();
    void pressureChanged();
    void reactorLevelChanged();
    void feedingExecutingStateChanged();
    void feedButtonOpacityChanged();
    void stepperSpeedChanged();
    void stepperDirectionChanged();
    void autoFeedCheckStateChanged();
    void serialPortListChanged();
    void portStateColorControlBoxChanged();
    void portStateColorSensorBoxChanged();

    void isTopValveSwitchOnChanged();
    void isBottomValveSwitchOnChanged();
    void isVacuumSwitchOnChanged();
    void isRotaryValveSwitchOnChanged();
    void isIgnitionSwitchOnChanged();
    void isFlareIgnitionSwitchOnChanged();
    void isWaterSwitchOnChanged();
    void isFansSwitchOnChanged();

    void startSequenceExecutingStateChanged();
    void checkboxFlareOnTempStateChanged();
    void checkboxFlareOnTimeStateChanged();
    void checkboxGlowOffTempStateChanged();
    void checkboxGlowOffTimeStateChanged();
    void checkboxFansOnTempStateChanged();

    //void continuousFeedChanged();


    void tempExitTriggerChanged();
    void timeFlareOnTriggerChanged();
    void tempMiddleTriggerChanged();
    void timeGlowOffTriggerChanged();
    void tempFansOnTriggerChanged();

    void serialOutputCSV_formatedChanged();


private slots:
     void readIncomingData();
     void updateControlBox(QString command);


public slots:
     void onCheckPortStateChanged();


private:
    const bool f_false = 0;
    const bool t_true = 1;

    bool serialChoice = false;
    bool ethernetChoice = false;

    bool firstTimeWrongLine = false;

    const QString dateTimeFormat = "ddd MMMM d yyyy hh:mm:ss.zzz";

    bool resetTimeTrigger = 0;

    QStringList s_serialPortList;
    QString delimiter = "\n";  // Used to find beggining.
    QString lastCompleteLine = "";

    QString t_tempValue1 = "-";
    QString t_tempValue2 = "-";
    QString t_tempValue3 = "-";
    QString t_tempValue4 = "-";
    QString t_tempValue5 = "-";
    QString t_tempValue6 = "-";
    QString t_tempValue7 = "-";
    QString t_tempValue8 = "-";

    QString t_tempWater1 = "-";

    QString f_flowValue1 = "-";
    QString f_flowValue2 = "-";

    QString p_pressureValue1 = "-";

    bool r_level = 0;  // Used as a buffer parameter to convert the incoming serial csv value to double and then fed into 'setReactorLevelState' function.
    int r_reactorLowCounter = 0;
    bool r_reactorLevelState = 0;
    bool reactorLevelLowStable = 0;

    bool f_feedingExecuting = 0;

    bool inAutoFeedCycle = 0;

    void automaticFeeding(double mass, int time);

    bool s_startSequenceInitiated = 0;   // Tells that program process is inside the start sequence.
    bool s_startSequenceExecuting = 0;  // Used to enable or disable start button.
    void startSequenceUpdateState();

    // Default automation settings:

    int s_stepperSpeed = 120.00001;
    QString s_stepperDirection = "+";
    //bool c_continuousFeed = 0;

    bool c_checkboxFlareOnTempState = 1;
    bool c_checkboxFlareOnTimeState = 1;
    bool c_checkboxGlowOffTempState = 1;
    bool c_checkboxGlowOffTimeState = 1;
    bool c_checkboxFansOnTempState = 1;

    int t_tempExitTrigger = 40;
    int t_timeFlareOnTrigger = 180;
    int t_tempMiddleGlowTrigger = 500;
    int t_timeGlowOffTrigger = 720;
    int t_tempFansOnTrigger = 60;    


    bool t_exitFlareTriggerHigh = 0;
    bool t_middleGlowTriggerHigh = 0;
    bool t_h2oFansTriggerHigh = 0;

    // ===========================

    bool a_autoFeedCheckState = 0; // bool

    bool i_isTopValveSwitchOn = 0;
    bool i_isBottomValveSwitchOn = 0;
    bool i_isVacuumSwitchOn = 0;
    bool i_isRotaryValveSwitchOn = 0;
    bool i_isIgnitionSwitchOn = 0;
    bool i_isFlareIgnitionSwitchOn = 0;
    bool i_isWaterSwitchOn = 0;
    bool i_isFansSwitchOn = 0;

    QString c_portStateColorControlBox = "#ffffff";
    QString c_portStateColorSensorBox = "#ffffff";    


    QSerialPort *arduino1;
    QSerialPort *arduino2;
    GuiSocket *ethernetSensorSocket;
    GuiSocket *ethernetControlSocket;
    QString sernsorIP = "169.254.240.101";
    QString controlIP = "169.254.240.102";
    QString arduino_controlbox_port = "-";
    QString arduino_sensorbox_port = "-";
    static const quint16 arduino_controlbox_vendor_id = 6790; // Need to find out.
    static const quint16 arduino_controlbox_product_id = 29987; // Need to find out.
    static const quint16 arduino_sensorbox_vendor_id = 6790; // Need to find out.
    static const quint16 arduino_sensorbox_product_id = 29987; // Need to find out.    
    bool arduino_controlbox_is_available;
    bool arduino_sensorbox_is_available;
    QByteArray incomingData;

};

#endif // COMMUNICATION_H
