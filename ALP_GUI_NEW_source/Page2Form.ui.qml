import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Extras 1.4
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {

    id: item1
    width: 1024
    height: 768
    opacity: 1

    property color transparentBackgraoundClr: "#000000"; // Color for transparent rectangles behind items.
    property double transparentBackgraoundOpacity: 0.03

    property alias checkboxFlareOnTemp: checkboxFlareOnTemp
    property alias checkboxFlareOnTime: checkboxFlareOnTime
    property alias checkboxGlowOffTemp: checkboxGlowOffTemp
    property alias checkboxGlowOffTime: checkboxGlowOffTime
    property alias checkboxFansOnTemp: checkboxFansOnTemp

    property alias textFieldFlareOnTemp: textFieldFlareOnTemp
    property alias textFieldFlareOnTime: textFieldFlareOnTime
    property alias textFieldGlowOffTemp: textFieldGlowOffTemp
    property alias textFieldGlowOffTime: textFieldGlowOffTime
    property alias textFieldFansOnTemp: textFieldFansOnTemp
    property alias buttonAcceptStartSettings: buttonAcceptStartSettings

    property alias textFieldStepperSpeed: textFieldStepperSpeed
    property alias switchStepperDirection: switchStepperDirection
    property alias buttonAcceptStepperSettings: buttonAcceptStepperSettings

    //property var kgPerHour: kgPerHour
    //property alias textKgHour: textKgHour


    Rectangle {
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
       /* gradient: Gradient {
            GradientStop {
                position: 0
                color: "#1f4b4d"
            }

            GradientStop {
                position: 0.432
                color: "#78a38f"
            }

            GradientStop {
                position: 0.724
                color: "#5b6965"
            }

            GradientStop {
                position: 0.878
                color: "#314345"
            }

            GradientStop {
                position: 1
                color: "#f2f2f2"
            }

            GradientStop {
                position: 0.949
                color: "#051f2c"
            }
        }*/

        anchors.fill: parent

        Image {
            id: logo
            source: "files/Images/ALP+TECH+LOGO+white.png"
            width: 240
            height: 110
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: 30
            opacity: 0.30
        }

    }

    RowLayout {
        id: rowLayoutMain        
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10


        ColumnLayout {
            id: columnLayoutLeftSide            
            Layout.fillWidth: true

            ColumnLayout {
                id: columnLayoutStartSettings
                Layout.fillWidth: true

                RectangularGlow {
                    id: effectStart1
                    glowRadius: 10
                    spread: 0.3
                    color: transparentBackgraoundClr
                    cached: false
                    z: -1
                    opacity: transparentBackgraoundOpacity
                    cornerRadius: 4
                    anchors.fill: parent
                }

                RowLayout {

                    Text {
                        id: textStartSettingsLabel
                        text: qsTr("Start Sequence Settings")
                        font.bold: true
                        font.pixelSize: 16
                    }

                    Item {
                        Layout.minimumWidth: 5
                    }

                    /*Button {
                        id: buttonExplanation
                        text: qsTr("Help / Explanation")
                        font.pixelSize: 8

                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 5
                            opacity: 0.2
                            border.color: buttonExplanation.down ? "#000000" : "#375056"
                            border.width: 1
                            radius: 3
                        }
                    }*/

                }



                Text {
                    id: textFlareTriggerLabel
                    text: qsTr("Flare <b>ON</b> trigger:")
                    font.underline: false
                    font.pixelSize: 12
                }


                RowLayout {
                    id: row1

                    CheckBox {
                        id: checkboxFlareOnTemp
                        checked: comm.checkboxFlareOnTempState
                    }

                    Text {
                        id: textFlareOnTempLabel
                        textFormat: Text.RichText
                        text: qsTr("T<sub>EXIT</sub> >")
                        Layout.maximumWidth: 60
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 14
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: textFieldFlareOnTemp
                        text: comm.tempExitTrigger
                        Layout.maximumWidth: 70
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "000"
                        color: "#000000"
                    }

                    Text {
                        id: textFlareOnCelsius
                        text: qsTr(" C")
                        horizontalAlignment: Text.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }


                }

                RowLayout {
                    id: row2
                    CheckBox {
                        id: checkboxFlareOnTime
                        checked: comm.checkboxFlareOnTimeState
                    }

                    Text {
                        id: textFlareOnSecondsLabel
                        text: qsTr("Time  ")
                        Layout.minimumWidth: 60
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: textFieldFlareOnTime
                        text: comm.timeFlareOnTrigger
                        Layout.maximumWidth: 70
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "000"
                        color: "#000000"
                    }

                    Text {
                        id: textFlareOnSeconds
                        text: qsTr(" Seconds")
                        horizontalAlignment: Text.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }
                }

                Text {
                    id: textGlowPugsOffLabel
                    text: qsTr("Glow plugs <b>OFF</b> trigger:")
                    font.underline: false
                    font.pixelSize: 12
                }

                RowLayout {
                    id: row3

                    CheckBox {
                        id: checkboxGlowOffTemp
                        checked: comm.checkboxGlowOffTempState
                    }

                    Text {
                        id: textGlowOffTempLabel
                        textFormat: Text.RichText
                        text: qsTr("T<sub>MIDDLE</sub> >")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.maximumWidth: 60
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 14
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: textFieldGlowOffTemp
                        text: comm.tempMiddleTrigger
                        Layout.maximumWidth: 70
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "000"
                        color: "#000000"
                    }

                    Text {
                        id: textGlowOffCelsius
                        text: qsTr(" C")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }


                }

                RowLayout {
                    id: row4
                    CheckBox {
                        id: checkboxGlowOffTime
                        checked: comm.checkboxGlowOffTimeState
                    }

                    Text {
                        id: textGlowOffSecondsLabel
                        text: qsTr("Time  ")
                        verticalAlignment: Text.AlignVCenter
                        Layout.minimumWidth: 60
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: textFieldGlowOffTime
                        text: comm.timeGlowOffTrigger
                        Layout.maximumWidth: 70
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "000"
                        color: "#000000"
                    }

                    Text {
                        id: textGlowOffSeconds
                        text: qsTr(" Seconds")
                        horizontalAlignment: Text.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }
                }

                Text {
                    id: textFansOnLabel
                    text: qsTr("Cooling Fans <b>ON</b> trigger:")
                    font.underline: false
                    font.pixelSize: 12
                }

                RowLayout {
                    id: row5

                    CheckBox {
                        id: checkboxFansOnTemp
                        checked: comm.checkboxFansOnTempState
                    }

                    Text {
                        id: textFansOnTempLabel
                        textFormat: Text.RichText
                        text: qsTr("T<sub>H2O</sub> >")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.maximumWidth: 60
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 14
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: textFieldFansOnTemp
                        text: comm.tempFansOnTrigger
                        Layout.maximumWidth: 70
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "00"
                        color: "#000000"
                    }

                    Text {
                        id: textFansOnCelsius
                        text: qsTr(" C")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                        font.bold: true
                        Layout.fillWidth: true
                    }


                }

                Button {
                    id: buttonAcceptStartSettings
                    text: qsTr("<b>Accept Start Settings</b>")
                    opacity: 0.6
                    highlighted: true
                    Layout.fillWidth: true
                }





            }

            Item {
                Layout.minimumHeight: 15
            }

            ColumnLayout {
                id: columnLayoutAutoFeed
                Layout.fillWidth: true


                RectangularGlow {
                    id: effectFeed1
                    glowRadius: 10
                    spread: 0.3
                    color: transparentBackgraoundClr
                    cached: false
                    z: -1
                    opacity: transparentBackgraoundOpacity
                    cornerRadius: 4
                    anchors.fill: parent
                }


                Text {
                    id: textStepperSettingsLabel
                    text: qsTr("Stepper Motor Settings")
                    font.bold: true
                    font.pixelSize: 16

                }


                Text {
                    id: textStepperSpped
                    text: qsTr("Stepper Speed")
                    font.pixelSize: 12
                }

                RowLayout {

                    TextField {
                        id: textFieldStepperSpeed
                        text: comm.stepperSpeed
                        Layout.maximumWidth: 80
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 10
                        inputMask: "000"
                        color: "#000000"
                    }

                    Text {
                        id: textKg
                        text: qsTr("rpm - (min 31 rpm)")
                        font.pixelSize: 12
                        font.bold: true
                    }

                    /*Text {
                        id: textKgHour
                        text: kgPerHour
                        font.pixelSize: 12

                    }

                    Text {
                        id: textKgHourUnit
                        text: qsTr("Kg/h - (On continuous)")
                        font.pixelSize: 12
                    }*/

                }

                Text {
                    id: textStepperDirection
                    text: qsTr("Stepper Motor Direction")
                    font.pixelSize: 12
                }

                RowLayout {
                    Text {
                        id: textCCW
                        text: qsTr("CCW")
                        font.pixelSize: 12
                    }
                    Switch {
                        id: switchStepperDirection
                        text: qsTr("Dir")
                        checked: true
                    }

                    Text {
                        id: textCW
                        text: qsTr("CW")
                        font.pixelSize: 12
                    }


                }

                Button {
                    id: buttonAcceptStepperSettings
                    text: qsTr("<b>Accept Stepper Settings</b>")
                    opacity: 0.6
                    highlighted: true
                    Layout.fillWidth: true
                }
            }

        }
        ColumnLayout {
            id: columnLayoutRightSide
            x: 502
            y: 134
            width: 100
            height: 100
            Layout.fillHeight: true


        }


    }
}
