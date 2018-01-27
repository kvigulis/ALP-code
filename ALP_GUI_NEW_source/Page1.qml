import QtQuick 2.7
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4



Page1Form {    

    pelletMass: textField.text

    isAutoFeedChecked: checkDelegateAutoFeeding.checked

    connectEthernet.onClicked:
    {
        comm.startEthernetCommunication();
    }

    buttonRefreshPorts.onClicked:
    {

        console.log("Button Refresh ports clicked.");
        comm.refreshPorts();

    }

    buttonApplyPortSettings.onClicked:
    {
        comm.startSerialCommunication();
    }

    comboBoxSerialPortsControl.onActivated:
    {
        console.log('CONTROL box port Changed (QML console)');
        comm.acceptPortControlBox(comboBoxSerialPortsControl.currentIndex);
    }

    comboBoxSerialPortsSensors.onActivated:
    {
        console.log('SENSOR box port Changed (QML console)');
        comm.acceptPortSensorBox(comboBoxSerialPortsSensors.currentIndex);
    }

    buttonTerminalWindow.onClicked:
    {
        onClicked: terminalWindow.visible = !terminalWindow.visible
        //textCSV.text = comm.serialOutputCSV_formated;
    }


    buttonClearDataStream.onClicked:
    {
        console.log("Button Clear Data Stream clicked.");
        comm.clearStream();
        //textCSV.text = comm.serialOutputCSV_formated;
    }

    buttonSaveCSV.onClicked:
    {
        console.log("Button Save CSV clicked.");
        csv.saveFile();
    }


    // Start Button

    beginStartSequence.onClicked:
    {
        comm.startButtonClicked();
    }

    stopEverything.onClicked:
    {
        comm.stopEverythingClicked();
    }

    // Feeding Buttons and Inputs:

    checkDelegateAutoFeeding.onClicked:
    {
        comm.autoFeedCheckState = checkDelegateAutoFeeding.checked
    }

    /*checkDelegateContinuousFeeding.onClicked:
    {
        comm.continuousFeed = checkDelegateContinuousFeeding.checked
    }*/

    stopFeeding.onClicked:
    {
       comm.stopFeeding();
       isAutoFeedChecked = false;  // Uncheck box in the GUI
       comm.autoFeedCheckState = checkDelegateAutoFeeding.checked // Send the unchecked box value to the Communication class object.
    }

    buttonFeedPellets.onClicked:
    {
        comm.feedPellets(pelletMass);
    }

    // Left Side Switches / Buttons

    switchTopValve.onCheckedChanged:
    {

        comm.topValveSwitchPressed(switchTopValve.checked);
        if(switchTopValve.checked)
        {
        comm.bottomValveSwitchPressed(false);
            switchBottomValve.checked = false;
        }
    }

    switchBottomValve.onCheckedChanged:
    {
        comm.bottomValveSwitchPressed(switchBottomValve.checked);

        if(!switchBottomValve.checked)
                {
                    switchRotaryValve.enabled = false;
                }
        else
        {
            switchRotaryValve.enabled = true;
            switchTopValve.checked = false;
        }
    }

    switchVacuum.onCheckedChanged:
    {
        comm.vacuumSwitchPressed(switchVacuum.checked);
    }

    switchRotaryValve.onCheckedChanged:
    {
        if(switchRotaryValve.checked){
        comm.rotaryValveSwitchPressed(comm.stepperSpeed, comm.stepperDirection);
        }
        else
        {
        comm.rotaryValveSwitchPressed("000", comm.stepperDirection);   // if rotarySwitch switch is OFF set stepper speed to 0.
        }
   }

    // Right side Switches / Buttons

    switchReactorIgnition.onCheckedChanged:
    {
        comm.ignitionSwitchPressed(switchReactorIgnition.checked);
    }

    switchFlareIgnition.onCheckedChanged: {
        comm.flareIgnitionSwitchPressed(switchFlareIgnition.checked);
    }

    switchFANS.onCheckedChanged:
    {
        comm.fansSwitchPressed(switchFANS.checked);
    }

    switchWaterPump.onCheckedChanged:
    {
        comm.waterSwitchPressed(switchWaterPump.checked)
    }

    // Stepper Speed

    /*buttonAcceptStepperSettings.onClicked:
    {
        comm.stepperSpeed = textFieldStepperSpeed.text
    }*/


    // Temperature Gauge color variation gradient
    /*
    gaugeColorTemp1:

        if (gaugeTemp1.value >= 750){
            return Qt.rgba((gaugeTemp1.value - 350) / (gaugeTemp1.maximumValue - 800), 1 - (gaugeTemp1.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp1.value >= 400){
            return Qt.rgba((gaugeTemp1.value - 350) / (gaugeTemp1.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp1.maximumValue - 900), (gaugeTemp1.value - 180) / 220, 1 - gaugeTemp1.value / (gaugeTemp1.maximumValue - 800), 1)
        }

    gaugeColorTemp2:

        if (gaugeTemp2.value >= 750){
            return Qt.rgba((gaugeTemp2.value - 350) / (gaugeTemp2.maximumValue - 800), 1 - (gaugeTemp2.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp2.value >= 400){
            return Qt.rgba((gaugeTemp2.value - 350) / (gaugeTemp2.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp2.maximumValue - 900), (gaugeTemp2.value - 180) / 220, 1 - gaugeTemp2.value / (gaugeTemp2.maximumValue - 800), 1)
        }

    gaugeColorTemp3:

        if (gaugeTemp3.value >= 750){
            return Qt.rgba((gaugeTemp3.value - 350) / (gaugeTemp3.maximumValue - 800), 1 - (gaugeTemp3.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp3.value >= 400){
            return Qt.rgba((gaugeTemp3.value - 350) / (gaugeTemp3.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp3.maximumValue - 900), (gaugeTemp3.value - 180) / 220, 1 - gaugeTemp3.value / (gaugeTemp3.maximumValue - 800), 1)
        }

    gaugeColorTemp4:

        if (gaugeTemp4.value >= 750){
            return Qt.rgba((gaugeTemp4.value - 350) / (gaugeTemp4.maximumValue - 800), 1 - (gaugeTemp4.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp4.value >= 400){
            return Qt.rgba((gaugeTemp4.value - 350) / (gaugeTemp4.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp4.maximumValue - 900), (gaugeTemp4.value - 180) / 220, 1 - gaugeTemp4.value / (gaugeTemp4.maximumValue - 800), 1)
        }

    gaugeColorTemp5:

        if (gaugeTemp5.value >= 750){
            return Qt.rgba((gaugeTemp5.value - 350) / (gaugeTemp5.maximumValue - 800), 1 - (gaugeTemp5.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp5.value >= 400){
            return Qt.rgba((gaugeTemp5.value - 350) / (gaugeTemp5.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp5.maximumValue - 900), (gaugeTemp5.value - 180) / 220, 1 - gaugeTemp5.value / (gaugeTemp5.maximumValue - 800), 1)
        }

    gaugeColorTemp6:

        if (gaugeTemp6.value >= 750){
            return Qt.rgba((gaugeTemp6.value - 350) / (gaugeTemp6.maximumValue - 800), 1 - (gaugeTemp6.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp6.value >= 400){
            return Qt.rgba((gaugeTemp6.value - 350) / (gaugeTemp6.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp6.maximumValue - 900), (gaugeTemp6.value - 180) / 220, 1 - gaugeTemp6.value / (gaugeTemp6.maximumValue - 800), 1)
        }

    gaugeColorTemp7:

        if (gaugeTemp7.value >= 750){
            return Qt.rgba((gaugeTemp7.value - 350) / (gaugeTemp7.maximumValue - 800), 1 - (gaugeTemp7.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp7.value >= 400){
            return Qt.rgba((gaugeTemp7.value - 350) / (gaugeTemp7.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp7.maximumValue - 900), (gaugeTemp7.value - 180) / 220, 1 - gaugeTemp7.value / (gaugeTemp7.maximumValue - 800), 1)
        }

    gaugeColorTemp8:

        if (gaugeTemp8.value >= 750){
            return Qt.rgba((gaugeTemp8.value - 350) / (gaugeTemp8.maximumValue - 800), 1 - (gaugeTemp8.value-600)/450 , 0, 1)
        }
        else if(gaugeTemp8.value >= 400){
            return Qt.rgba((gaugeTemp8.value - 350) / (gaugeTemp8.maximumValue - 800), 1 , 0, 1)
        }

        else{
            return Qt.rgba(0 / (gaugeTemp8.maximumValue - 900), (gaugeTemp8.value - 180) / 220, 1 - gaugeTemp8.value / (gaugeTemp8.maximumValue - 800), 1)
        }*/

}
