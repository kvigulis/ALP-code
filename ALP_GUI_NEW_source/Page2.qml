import QtQuick 2.7

Page2Form {

    //kgPerHour : textKgHour.text

    /*checkboxFlareOnTemp.onClicked: {
        comm.checkboxFlareOnTempState = checkboxFlareOnTemp.checked
    }

    checkboxFlareOnTime.onClicked: {
        comm.checkboxFlareOnTimeState = checkboxFlareOnTime.checked
    }

    checkboxGlowOffTemp.onClicked: {
        comm.checkboxGlowOffTempState = checkboxGlowOffTemp.checked
    }

    checkboxGlowOffTime.onClicked: {
        comm.checkboxGlowOffTimeState = checkboxGlowOffTime.checked
    }

    checkboxFansOnTemp.onClicked: {
        comm.checkboxFansOnTempState = checkboxFansOnTemp.checked
    }*/


    buttonAcceptStartSettings.onClicked:
    {
        comm.tempExitTrigger = textFieldFlareOnTemp.text
        comm.timeFlareOnTrigger = textFieldFlareOnTime.text
        comm.tempMiddleTrigger = textFieldGlowOffTemp.text
        comm.timeGlowOffTrigger = textFieldGlowOffTime.text
        comm.tempFansOnTrigger = textFieldFansOnTemp.text
        comm.checkboxFlareOnTempState = checkboxFlareOnTemp.checked
        comm.checkboxFlareOnTimeState = checkboxFlareOnTime.checked
        comm.checkboxGlowOffTempState = checkboxGlowOffTemp.checked
        comm.checkboxGlowOffTimeState = checkboxGlowOffTime.checked
        comm.checkboxFansOnTempState = checkboxFansOnTemp.checked
    }


    buttonAcceptStepperSettings.onClicked: {
        comm.stepperSpeed = textFieldStepperSpeed.text;
        if(switchStepperDirection.checked)
        {
        comm.stepperDirection = "+";
        }
        else{
        comm.stepperDirection = "-";
        }


        //kgPerHour = 10;

    }

}
