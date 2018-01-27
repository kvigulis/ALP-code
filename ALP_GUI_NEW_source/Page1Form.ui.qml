import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0

import QtQuick.Controls.Styles 1.4

import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
//import QtCharts 2.2


Item {

    // Color and opacity settings.
    property color sideColors: "#778899"
    property double sideOpacity: 0.4
    property color transparentBackgraoundClr: "#000000"; // Color for transparent rectangles behind items.
    property double transparentBackgraoundOpacity: 0.03
    property color blockDigitClr: "#000000"; // The less transparent blocks behind digits.
    property double blockDigitOpacity: 0.08
    property color midBottomClr: "#000000";
    property double midBottomOpacity: 0
    property color tickColorHigh: "#d20000";
    property color tickColor: "#000000";

    property var terminalWindow: Window {
        width: 720
        height: 240
        color: "#337777"
        title: "CVS output data"
        opacity: 0.65
        flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowMaximizeButtonHint

        ScrollView {
            anchors.fill: parent
            Text {
                id: textCSV
                text: comm.serialOutputCSV_formated
            }
        }
    }

    property alias textCSV : textCSV

    property alias buttonTerminalWindow: buttonTerminalWindow
    property alias buttonSaveCSV: buttonSaveCSV
    property alias buttonClearDataStream: buttonClearDataStream

    property alias connectEthernet: connectEthernet
    property alias buttonRefreshPorts: buttonRefreshPorts
    property alias buttonApplyPortSettings: buttonApplyPortSettings
    property alias comboBoxSerialPortsControl: comboBoxSerialPortsControl
    property alias comboBoxSerialPortsSensors: comboBoxSerialPortsSensors

    property alias beginStartSequence: beginStartSequence
    property alias stopEverything: stopEverything

    property alias checkDelegateAutoFeeding: checkDelegateAutoFeeding  // AUTO FEEDING
    property alias stopFeeding: stopFeeding
    property alias buttonFeedPellets: buttonFeedPellets

    property alias switchTopValve: switchTopValve  // Left side control buttons
    property alias switchBottomValve: switchBottomValve
    property alias switchVacuum: switchVacuum
    property alias switchRotaryValve: switchRotaryValve

    property alias switchReactorIgnition: switchReactorIgnition // Right side control buttons
    property alias switchFlareIgnition: switchFlareIgnition
    property alias switchFANS: switchFANS
    property alias switchWaterPump: switchWaterPump

    property var isAutoFeedChecked: isAutoFeedChecked
    property var pelletMass: pelletMass
    property var textField: textField
    width: 1300
    height: 800


    //property alias buttonAcceptStepperSettings: buttonAcceptStepperSettings
    //property alias textFieldStepperSpeed: textFieldStepperSpeed
    //property alias checkDelegateContinuousFeeding: checkDelegateContinuousFeeding


    Rectangle {
        width: 1200
        height: 800
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

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

        RowLayout {
            id: rowLayoutMain
            anchors.fill: parent


            RowLayout {

                Item {
                    width: 1
                }

                RectangularGlow {
                    id: effectLeftColumn
                    glowRadius: 1
                    spread: 0.3
                    color: sideColors
                    cached: false
                    z: -1
                    opacity: sideOpacity
                    cornerRadius: 4
                    anchors.fill: parent
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumHeight: 720
                    Layout.minimumWidth: 200



                    Item {
                        height: 2
                    }

                    RowLayout{
                        Button {
                            id: buttonTerminalWindow
                            text: qsTr("CSV log Terminal")
                            opacity: 0.3
                            highlighted: true
                            Layout.fillWidth: true
                        }

                    }

                    RowLayout {
                        id: rowLeftLeft
                        Layout.fillWidth: true

                        ColumnLayout {

                            Button {
                                id: buttonSaveCSV
                                text: qsTr("Save CSV file")
                                highlighted: true
                                opacity: 0.3
                                Layout.fillWidth: true
                            }
                        }

                        ColumnLayout {

                            Button {
                                id: buttonClearDataStream
                                text: qsTr("Clear Data Stream")
                                highlighted: true
                                opacity: 0.3
                                Layout.fillWidth: true
                            }
                        }
                    }

                    // Paste Ethernet -----------------------------------:

                    ColumnLayout {

                        Item{
                            height: 4
                        }

                        Button {
                            id: connectEthernet
                            opacity: 0.6

                            RectangularGlow {
                                id: effectConnect
                                glowRadius: 10
                                spread: 0.2
                                color: transparentBackgraoundClr
                                cached: false
                                z: -1
                                opacity: transparentBackgraoundOpacity
                                cornerRadius: 4
                                anchors.fill: parent
                            }


                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop


                            background: Rectangle {
                                color: "#222222"
                                implicitWidth: 180
                                implicitHeight: 60
                                opacity: enabled ? 0.8 : 0.3
                                border.color: connectEthernet.down ? "#003366" : "#375056"
                                border.width: 1
                                radius: 3
                            }

                            contentItem: Text {
                                text: "<b>Connect</b><"
                                font.pixelSize: 22
                                style: connectEthernet.down ? Text.Outline : Text.Normal
                                styleColor: "#638c97"
                                opacity: 1.0
                                color: connectEthernet.down ? "#ffff22" : "#ffffff"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }
                        }
                    }

                    // Ethernet "Connect" button part ends here...


                    RowLayout {
                        id: rowLeftLeft2
                        Layout.fillWidth: true

                        ColumnLayout {

                            Item{
                                height: 1
                            }

                            Text {
                                id: controlBoxComboText
                                Layout.preferredHeight: 40
                                color: "#000000"
                                text: qsTr("Control box")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                style: Text.Normal
                                opacity: 0.6
                                font.bold: true
                                font.pixelSize: 14
                                Layout.fillWidth: true

                                RectangularGlow {
                                    id: effectControlBox
                                    glowRadius: 1
                                    spread: 0.3
                                    color: comm.portStateColorControlBox
                                    cached: false
                                    z: -1
                                    opacity: 0.8
                                    cornerRadius: 4
                                    anchors.fill: parent
                                }
                            }

                            Text {
                                id: sensorBoxComboText
                                Layout.preferredHeight: 40
                                color: "#000000"
                                text: qsTr("Sensor box")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                style: Text.Normal
                                opacity: 0.6
                                font.bold: true
                                font.pixelSize: 14
                                Layout.fillWidth: true

                                RectangularGlow {
                                    id: effectSensorBox
                                    glowRadius: 1
                                    spread: 0.3
                                    color: comm.portStateColorSensorBox
                                    cached: false
                                    z: -1
                                    opacity: 0.8
                                    cornerRadius: 4
                                    anchors.fill: parent
                                }
                            }

                            Button {

                                id: buttonRefreshPorts
                                text: qsTr("Refresh Ports")
                                opacity: 0.3
                                highlighted: true
                                Layout.fillWidth: true
                            }

                            Item{
                                height: 5
                            }
                        }

                        ColumnLayout {

                            Item{
                                height: 1
                            }

                            ComboBox {
                                id: comboBoxSerialPortsControl
                                opacity: 0.5
                                model: comm.serialPortList
                                Layout.fillWidth: true
                            }

                            ComboBox {
                                id: comboBoxSerialPortsSensors
                                opacity: 0.5
                                model: comm.serialPortList
                                Layout.fillWidth: true

                            }

                            Button {
                                id: buttonApplyPortSettings
                                text: qsTr("Start COM")
                                opacity: 0.3
                                highlighted: true
                                Layout.fillWidth: true
                            }

                            Item{
                                height: 5
                            }
                        }
                    } // Serial port part ends here..



                    RowLayout {
                        id: leftButtonsColumnTopSpacer
                    }

                    ColumnLayout
                    {
                        id: leftButtonsColumn
                        Layout.alignment: Qt.AlignHLeft | Qt.AlignVCenter

                        Switch {
                            id: switchTopValve
                            text: qsTr("Top Valve Open/Close")
                            checked: comm.isTopValveSwitchOn
                        }

                        Switch {
                            id: switchBottomValve
                            text: qsTr("Bottom Valve Open/Close")
                            checked: comm.isBottomValveSwitchOn
                        }

                        Switch {
                            id: switchVacuum
                            text: qsTr("Vacuum ON/OFF")
                            checked: comm.isVacuumSwitchOn
                        }

                        Switch {
                            id: switchRotaryValve
                            text: qsTr("Rotary valve ON/OFF")
                            checked: comm.isRotaryValveSwitchOn
                            enabled: false
                        }

                    }

                    ColumnLayout {
                        id: leftButtonsColumnBottomMargin
                    }

                    RowLayout {
                        id: leftButtonsColumnBottomMargin2
                    }
                }

                Item {
                    width: 1
                }
            }  // Left Main Collumn End Curly Brace.

            Item {
                id: leftVerticalSpacer
                width: 4
            }

            ColumnLayout {

                // MIDDLE SECTION

                Layout.maximumWidth: 1400
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Layout.minimumWidth: 850
                Layout.fillHeight: true

                Item{
                    height: 10
                }                


                RowLayout {   //    Temperature gauges and labels.
                    id: rowLayoutTemperatures
                    Layout.minimumHeight: 350
                    //Layout.maximumHeight: 700
                    Layout.minimumWidth: 400
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop


                    ColumnLayout {

                        id: columnLayoutT1
                        x: 505
                        y: 115
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect1
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text1
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Bottom</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect1t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text1b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }



                        RectangularGlow {
                            id: effect9
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text9
                            textFormat: Text.RichText
                            text: qsTr("T<sub>9</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect9t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text9b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempWater1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect17
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text17
                            textFormat: Text.RichText
                            text: qsTr("T<sub>17</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect17t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text17b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT2
                        x: 505
                        y: 115
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect2
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }




                        Text {
                            id: text2
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Middle</sub>")
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect2t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text2b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue2
                            style: Text.Outline
                            font.italic: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect10
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text10
                            textFormat: Text.RichText
                            text: qsTr("T<sub>10</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect10t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text10b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect18
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text18
                            textFormat: Text.RichText
                            text: qsTr("T<sub>18</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect18t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text18b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT3
                        x: 505
                        y: 115
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect3
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                     

                        Text {
                            id: text3
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Top</sub>")
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect3t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text3b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue3
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                        RectangularGlow {
                            id: effect11
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text11
                            textFormat: Text.RichText
                            text: qsTr("T<sub>11</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect11t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text11b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect19
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text19
                            textFormat: Text.RichText
                            text: qsTr("T<sub>19</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect19t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text19b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT4
                        x: 505
                        y: 115
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect4
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                        

                        Text {
                            id: text4
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Upper Middle</sub>")
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect4t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text4b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue4
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect12
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text12
                            textFormat: Text.RichText
                            text: qsTr("T<sub>12</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect12t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text12b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect20
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text20
                            textFormat: Text.RichText
                            text: qsTr("T<sub>20<sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect20t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text20b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT5
                        x: 505
                        y: 115
                        width: 100
                        height: 0

                        RectangularGlow {
                            id: effect5
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                        

                        Text {
                            id: text5
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Lid</sub>")
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect5t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text5b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue5
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect13
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text13
                            textFormat: Text.RichText
                            text: qsTr("T<sub>13</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect13t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text13b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect21
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text21
                            textFormat: Text.RichText
                            text: qsTr("T<sub>21</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect21t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text21b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT6
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect6
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                        

                        Text {
                            id: text6
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Exit</sub>")
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect6t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text6b
                            color: "#f9f2bd"
                            text: comm.tempValue6
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect14
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text14
                            textFormat: Text.RichText
                            text: qsTr("T<sub>14</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect14t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text14b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect22
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text22
                            textFormat: Text.RichText
                            text: qsTr("T<sub>22</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect22t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text22b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT7
                        width: 100
                        height: 0
                        Layout.minimumWidth: 90

                        RectangularGlow {
                            id: effect7
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                        

                        Text {
                            id: text7
                            textFormat: Text.RichText
                            text: qsTr("T<sub>Cyclone</sub>")
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect7t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text7b
                            color: "#f9f2bd"
                            text: comm.tempValue7
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect15
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text15
                            textFormat: Text.RichText
                            text: qsTr("T<sub>15</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect15t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text15b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect23
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text23
                            textFormat: Text.RichText
                            text: qsTr("T<sub>23</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect23t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text23b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }
                    }

                    Item{
                        width: 5
                    }

                    ColumnLayout {
                        id: columnLayoutT8
                        width: 100
                        height: 0

                        RectangularGlow {
                            id: effect8
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }                        

                        Text {
                            id: text8
                            textFormat: Text.RichText
                            text: qsTr("T<sub>H20</sub>")
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true
                            Layout.minimumWidth: 90
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect8t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text8b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue8
                            style: Text.Outline
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect16
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text16
                            textFormat: Text.RichText
                            text: qsTr("T<sub>16</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect16t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text16b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                        RectangularGlow {
                            id: effect24
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }



                        Text {
                            id: text24
                            textFormat: Text.RichText
                            text: qsTr("T<sub>24</sub>")
                            font.strikeout: false
                            font.underline: false
                            font.italic: false
                            style: Text.Normal
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 18
                        }

                        Text {
                            RectangularGlow {
                                id: effect24t
                                glowRadius: 3
                                spread: 0.1
                                color: blockDigitClr
                                cached: false
                                z: -1
                                opacity: blockDigitOpacity
                                cornerRadius: 3
                                anchors.fill: parent
                            }
                            id: text24b
                            x: 36
                            y: 333
                            color: "#f9f2bd"
                            text: comm.tempValue1
                            opacity: 1
                            styleColor: "#040404"
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            style: Text.Outline
                            font.underline: false
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            font.pixelSize: 32
                        }

                    }                    
                }

                Item{
                    height: 5
                }

                RowLayout {                 // Beneth the temperature gauges.
                    id: rowLayoutBottom                   
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumHeight: 120
                    Layout.maximumHeight: 200

                    RectangularGlow {  //  Background for bottom section
                        id: effectBottom
                        glowRadius: 10
                        spread: 0.3
                        color: midBottomClr
                        opacity: midBottomOpacity
                        cornerRadius: 4
                        anchors.fill: parent
                   }

                    ColumnLayout {
                        id: columnLayoutBottomLeft  // Both FLOWS column

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        RectangularGlow {
                            id: effectBottomLeft
                            glowRadius: 10
                            spread: 0.3
                            color: transparentBackgraoundClr
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent

                        }

                        RowLayout {
                            id: flowGaugeTitleVal1

                            Text {
                                id: textFLow1
                                text: qsTr("Flow 1")
                                Layout.maximumWidth: 200
                                style: Text.Normal
                                font.bold: true
                                Layout.minimumWidth: 90
                                Layout.fillWidth: false
                                font.pixelSize: 20
                            }

                            Text {
                                RectangularGlow {
                                    id: effectFlowText1
                                    glowRadius: 3
                                    spread: 0.1
                                    color: blockDigitClr
                                    z: -1
                                    opacity: blockDigitOpacity
                                    cornerRadius: 3
                                    anchors.fill: parent
                                }
                                id: textFlowVAL1
                                color: "#f9f2bd"
                                text: comm.flowValue1
                                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                style: Text.Outline
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                Layout.fillWidth: true
                                font.pixelSize: 28
                                Layout.maximumWidth: 150

                            }

                            Text {
                                id: textFLow1Unit
                                color: "#cdcdcd"
                                text: qsTr("  m3/s")
                                font.underline: false
                                font.italic: false
                                Layout.maximumWidth: 200
                                style: Text.Outline
                                font.bold: true
                                Layout.minimumWidth: 90
                                Layout.fillWidth: false
                                font.pixelSize: 15
                            }
                        }

                        RowLayout {
                            id: flowGaugeArea1

                            Gauge {
                                id: flowGauge1
                                Layout.minimumWidth: 350
                                minimumValue: 0
                                value: comm.flowValue1
                                maximumValue: 60
                                tickmarkStepSize : 5
                                orientation: Qt.Horizontal
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.maximumWidth: 950

                                style: GaugeStyle {
                                    valueBar: Rectangle {
                                        implicitWidth: 20
                                        color: "#aabbbb"
                                    }

                                    tickmarkLabel:  Text {
                                        text: styleData.value
                                        color: styleData.value >= 50 ? tickColorHigh : tickColor
                                        antialiasing: true
                                    }

                                    tickmark: Item {
                                        implicitWidth: 12
                                        implicitHeight: 3

                                        Rectangle {
                                            x: Qt.AlignRight
                                            width: 8
                                            height: parent.height
                                            color: styleData.value >= 50 ? tickColorHigh : tickColor
                                        }
                                    }

                                    minorTickmark: Item {
                                        implicitWidth: 10
                                        implicitHeight: 2
                                        Rectangle {
                                            x: Qt.AlignRight
                                            width: 6
                                            height: parent.height
                                            color: styleData.value >= 50 ? tickColorHigh : tickColor
                                        }
                                    }
                                }
                            }
                        }

                        Item
                        {
                            Layout.minimumHeight: 5
                            Layout.maximumHeight: 40
                            Layout.fillHeight: true
                        }

                        RowLayout {
                            id: flowGaugeTitleVal2

                            Text {
                                id: textFLow2
                                text: qsTr("Flow 2")
                                Layout.maximumWidth: 200
                                style: Text.Normal
                                font.bold: true
                                Layout.minimumWidth: 90
                                Layout.fillWidth: false
                                font.pixelSize: 20
                            }

                            Text {
                                RectangularGlow {
                                    id: effectFlowText2
                                    glowRadius: 3
                                    spread: 0.1
                                    color: blockDigitClr
                                    cached: false
                                    z: -1
                                    opacity: blockDigitOpacity
                                    cornerRadius: 3
                                    anchors.fill: parent
                                }
                                id: textFlowVAL2
                                color: "#f9f2bd"
                                text: comm.flowValue2
                                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                style: Text.Outline
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                Layout.fillWidth: true
                                font.pixelSize: 28
                                Layout.maximumWidth: 150

                            }

                            Text {
                                id: textFLow2Unit
                                color: "#cdcdcd"
                                text: qsTr("   m3/s")
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignTop
                                font.underline: false
                                font.italic: false
                                Layout.maximumWidth: 200
                                style: Text.Outline
                                font.bold: true
                                Layout.minimumWidth: 90
                                Layout.fillWidth: false
                                font.pixelSize: 15
                            }
                        }

                        Gauge {
                            id: flowGauge2
                            minimumValue: 0
                            value: comm.flowValue2
                            maximumValue: 60
                            tickmarkStepSize : 5
                            orientation: Qt.Horizontal
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.maximumWidth: 950

                            style: GaugeStyle {
                                valueBar: Rectangle {
                                    implicitWidth: 20
                                    color: "#aabbbb"
                                }
                                tickmarkLabel:  Text {
                                    text: styleData.value
                                    color: styleData.value >= 50 ? tickColorHigh : tickColor
                                    antialiasing: true
                                }

                                tickmark: Item {
                                    implicitWidth: 12
                                    implicitHeight: 3

                                    Rectangle {
                                        x: Qt.AlignRight
                                        width: 8
                                        height: parent.height
                                        color: styleData.value >= 50 ? tickColorHigh : tickColor
                                    }
                                }

                                minorTickmark: Item {
                                    implicitWidth: 10
                                    implicitHeight: 2
                                    Rectangle {
                                        x: Qt.AlignRight
                                        width: 6
                                        height: parent.height
                                        color: styleData.value >= 50 ? tickColorHigh : tickColor
                                    }
                                }
                            }
                        } // End of flow 2
                    } // Flow Column END

                    Item{
                        id: flowAndPressureSpacer
                        width: 5
                    }

                    ColumnLayout { // PRESSURE BOX
                        id: columnLayoutPressure
                        Layout.minimumWidth: 200
                        Layout.maximumWidth: 295

                        CircularGauge {

                            id: circularGauge2
                            Layout.minimumWidth: 180
                            Layout.maximumHeight: 450
                            Layout.maximumWidth: 295
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: comm.pressureValue1
                            maximumValue: 250

                            RectangularGlow {
                                id: effectCircularGauge
                                glowRadius: 10
                                spread: 0.3
                                color: transparentBackgraoundClr
                                opacity: transparentBackgraoundOpacity
                                cornerRadius: 4
                                anchors.fill: parent
                            }

                            style: CircularGaugeStyle {

                                labelStepSize: 50
                                minimumValueAngle : -90
                                maximumValueAngle: 150
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                tickmarkLabel:  Text {
                                    text: styleData.value
                                    color: styleData.value >= 200 ? tickColorHigh : tickColor
                                    antialiasing: true
                                }

                                tickmark: Rectangle {
                                    visible: styleData.value < 400 || styleData.value % 10 == 0
                                    implicitWidth: outerRadius * 0.02
                                    antialiasing: true
                                    implicitHeight: outerRadius * 0.06
                                    color: styleData.value >= 200 ? tickColorHigh : tickColor
                                }

                                minorTickmark: Rectangle {
                                    visible: styleData.value < 500
                                    implicitWidth: outerRadius * 0.01
                                    antialiasing: true
                                    implicitHeight: outerRadius * 0.03
                                    color: styleData.value >= 200 ? tickColorHigh : tickColor
                                }
                            }

                            ColumnLayout {
                                id: columnLayoutPressureText

                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10

                                Layout.maximumHeight: 150

                                anchors.fill: parent

                                Item{
                                    height: 40
                                }

                                RowLayout {
                                    id: topPressureText // The Value and mBar [unit]

                                    Text {

                                        RectangularGlow {
                                            id: effectPressureGlow
                                            glowRadius: 3
                                            spread: 0.1
                                            color: blockDigitClr
                                            cached: false
                                            z: -1
                                            opacity: blockDigitOpacity
                                            cornerRadius: 3
                                            anchors.fill: parent
                                        }

                                        id: textPressureVAL
                                        color: "#f9f2bd"
                                        text: comm.pressureValue1
                                        styleColor: "#000000"
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                                        style: Text.Outline
                                        font.bold: true
                                        font.pixelSize: 30
                                        Layout.maximumWidth: 180
                                        Layout.maximumHeight: 35
                                        anchors.left: parent.left
                                        anchors.leftMargin: 25
                                    }

                                    Text {

                                        RectangularGlow {
                                            id: effectPressureGlow2
                                            glowRadius: 3
                                            spread: 0.1
                                            color: blockDigitClr
                                            cached: false
                                            z: -1
                                            opacity: blockDigitOpacity
                                            cornerRadius: 3
                                            anchors.fill: parent
                                        }

                                        id: textPressureUnit
                                        color: "#d20000"
                                        text: qsTr("mBar")
                                        styleColor: "#d20000"
                                        font.underline: false
                                        font.italic: false
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                                        style: Text.Normal
                                        font.bold: true
                                        font.pixelSize: 25
                                        Layout.maximumWidth: 180
                                        Layout.maximumHeight: 35
                                        anchors.left: parent.left
                                        anchors.leftMargin: 100
                                    }
                                }
                            }
                        }
                    } // PRESSURE BOX END.

                    Item{
                        id: pressureAndRightQuadrantSpacer
                        width: 5
                    }

                    ColumnLayout{        // WHOLE DISTANCE AND FILL SECTION
                        id: wholeDistanceAndFillSectionColumn

                        RowLayout{
                            id: bothTopBoxesRow
                            Layout.fillHeight: true
                            Layout.minimumHeight: 120
                            ColumnLayout {
                                id: dist1Column
                                Layout.minimumWidth: 140
                                Layout.maximumWidth: 180
                                Layout.maximumHeight: 200


                                RectangularGlow {
                                    id: effectDistance1
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

                                    id: statusIndicatorLayout1
                                    Layout.minimumHeight: 10
                                    Layout.maximumHeight: 90

                                    StatusIndicator {
                                        id: statusIndicator1
                                        color: "#ff0000"
                                        active: false
                                        Layout.maximumHeight: 160
                                        Layout.fillWidth: true
                                        Layout.maximumWidth: 50
                                    }

                                    Text {
                                        id: textHopperLow1
                                        text: qsTr("Hopper Pellets LOW")
                                        Layout.fillHeight: false
                                        Layout.maximumWidth: 200
                                        Layout.maximumHeight: 30
                                        style: Text.Normal
                                        font.bold: true
                                        Layout.minimumWidth: 90
                                        Layout.fillWidth: false
                                        font.pixelSize: 10
                                    }

                                }

                                Text {
                                    id: textDistance1
                                    text: qsTr("Hopper Distance")
                                    opacity: 1
                                    styleColor: "#37555f"
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillHeight: true
                                    Layout.maximumWidth: 160
                                    Layout.maximumHeight: 30
                                    style: Text.Normal
                                    font.bold: true
                                    Layout.minimumWidth: 90
                                    Layout.fillWidth: true
                                    font.pixelSize: 16

                                }

                                Text {
                                    RectangularGlow {
                                        id: effectDistanceText1
                                        glowRadius: 3
                                        spread: 0.1
                                        color: blockDigitClr
                                        cached: false
                                        z: -1
                                        opacity: blockDigitOpacity
                                        cornerRadius: 3
                                        anchors.fill: parent
                                    }
                                    id: textDistanceVAL1
                                    color: "#f9f2bd"
                                    text: qsTr("---")
                                    Layout.fillHeight: false
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    style: Text.Outline
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.fillWidth: true
                                    font.pixelSize: 28
                                    Layout.maximumWidth: 250
                                }

                            } // Distance TOP section End

                            Item{
                                width: 5
                            }

                            ColumnLayout {
                                id: columnAutoFeedCheck
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.minimumWidth: 80
                                Layout.maximumWidth: 200
                                Layout.minimumHeight: 80
                                Layout.maximumHeight: 230

                                RectangularGlow {
                                    id: effectAutoFeed1
                                    glowRadius: 10
                                    spread: 0.3
                                    color: transparentBackgraoundClr
                                    cached: false
                                    z: -1
                                    opacity: transparentBackgraoundOpacity
                                    cornerRadius: 4
                                    anchors.fill: parent
                                }

                                CheckDelegate {

                                    id: checkDelegateAutoFeeding

                                    RectangularGlow {
                                        id: effectAutoFeeding1
                                        glowRadius: 10
                                        spread: 0.2
                                        color: transparentBackgraoundClr
                                        cached: false
                                        z: -1
                                        opacity: transparentBackgraoundOpacity
                                        cornerRadius: 4
                                        anchors.fill: parent
                                    }

                                    text: "Auto Feeding"
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    checked: isAutoFeedChecked

                                    background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 20
                                        opacity: enabled ? 0.5 : 0.3
                                        border.color: checkDelegateAutoFeeding.down ? "#000000" : "#375056"
                                        border.width: 1
                                        radius: 3
                                    }
                                }


                                Button {
                                    id: stopFeeding


                                    RectangularGlow {
                                        id: effectStopFeeding2
                                        glowRadius: 10
                                        spread: 0.2
                                        color: transparentBackgraoundClr
                                        cached: false
                                        z: -1
                                        opacity: transparentBackgraoundOpacity
                                        cornerRadius: 4
                                        anchors.fill: parent
                                    }

                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop


                                    background: Rectangle {
                                        color: "#ff2233"
                                        implicitWidth: 100
                                        implicitHeight: 50
                                        opacity: enabled ? 0.8 : 0.3
                                        border.color: stopFeeding.down ? "#660000" : "#375056"
                                        border.width: 1
                                        radius: 3
                                    }

                                    contentItem: Text {
                                        text: "<b>STOP</b> Feeding"
                                        font.pixelSize: 14
                                        style: stopFeeding.down ? Text.Outline : Text.Normal
                                        styleColor: "#660000"
                                        opacity: 1.0
                                        color: stopFeeding.down ? "#ffeeee" : "#ffffff"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        } // Two top box row END.

                        Item{
                            height: 5
                        }

                        RowLayout{
                            id: bothBottomBoxesRow
                            Layout.fillHeight: true

                            ColumnLayout {  // Left bottom Box
                                id: dist2Column
                                Layout.minimumWidth: 140
                                Layout.maximumWidth: 180
                                Layout.maximumHeight: 460

                                RectangularGlow {
                                    id: effectDistance2
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

                                    id: statusIndicatorLayout2
                                    Layout.minimumHeight: 10
                                    Layout.maximumHeight: 90

                                    StatusIndicator {
                                        id: statusIndicator2
                                        color: "#ff0000"
                                        active: comm.reactorLevelState
                                        Layout.maximumHeight: 160
                                        Layout.fillWidth: true
                                        Layout.maximumWidth: 50
                                    }

                                    Text {
                                        id: textReactorLow1
                                        text: qsTr("Reactor Pellets HIGH")
                                        Layout.fillHeight: false
                                        Layout.maximumWidth: 200
                                        Layout.maximumHeight: 30
                                        style: Text.Normal
                                        font.bold: true
                                        Layout.minimumWidth: 90
                                        Layout.fillWidth: false
                                        font.pixelSize: 10
                                    }

                                }

                                Text {
                                    id: textDistance2
                                    x: 36
                                    y: 333
                                    text: qsTr("Reactor Distance")
                                    opacity: 1
                                    styleColor: "#37555f"
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillHeight: true
                                    Layout.maximumWidth: 160
                                    Layout.maximumHeight: 30
                                    style: Text.Normal
                                    font.bold: true
                                    Layout.minimumWidth: 90
                                    Layout.fillWidth: true
                                    font.pixelSize: 16


                                }

                                Text {
                                    RectangularGlow {
                                        id: effectDistanceText2
                                        glowRadius: 3
                                        spread: 0.1
                                        color: blockDigitClr
                                        cached: false
                                        z: -1
                                        opacity: blockDigitOpacity
                                        cornerRadius: 3
                                        anchors.fill: parent
                                    }
                                    id: textDistanceVAL2
                                    color: "#f9f2bd"
                                    text: qsTr("---")
                                    Layout.fillHeight: false
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    style: Text.Outline
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.fillWidth: true
                                    font.pixelSize: 28
                                    Layout.maximumWidth: 250
                                }
                            }

                            Item{
                                width: 5
                            }

                            ColumnLayout {  // Right Bottom Box
                                id: columnFeedPellets
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.maximumWidth: 200

                                Item{
                                    height: 20
                                }

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

                                RowLayout {
                                    id: rowFeedPellets

                                    TextField {
                                        id: textField
                                        text: qsTr("3.0")
                                        font.italic: false
                                        font.bold: true
                                        font.pointSize: 10
                                        Layout.fillWidth: true
                                        inputMask: "0.0"
                                        color: "#000000"
                                    }

                                    Text {
                                        id: textPelletAmount
                                        Layout.fillWidth: true
                                        Layout.minimumWidth: 40
                                        text: qsTr(" kg")
                                        font.pointSize: 10
                                        font.bold: true
                                    }
                                }

                                Item{
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                }

                                Button {
                                    id: buttonFeedPellets
                                    enabled: !comm.feedingExecuting
                                    highlighted: false
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 20
                                        opacity: enabled ? 1 : 0.1
                                        border.color: buttonFeedPellets.down ? "#000000" : "#375056"
                                        border.width: 1
                                        radius: 3
                                    }

                                    contentItem: Text {
                                        text: qsTr("Feed Pellets")
                                        opacity: enabled ? 1 : 0.2
                                        color: buttonFeedPellets.down ? "#666666" : "#000000"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }
                                }

                                RowLayout{
                                    StatusIndicator {
                                        id: statusIndicator3
                                        color: "#beeff8"
                                        active: comm.feedingExecuting
                                        Layout.minimumWidth: 30
                                    }

                                    Text {
                                        id: textFillStillExecuting
                                        Layout.fillWidth: true
                                        Layout.minimumWidth: 40
                                        text: qsTr("Feeding")
                                        font.pointSize: 10
                                        font.bold: true
                                        color: "#000000"
                                    }
                                }
                            } //Bottom Right box END.
                        } // Both Bottom boxes END.
                    } // Whole Dist Fill Senction END.
                }   // BOTTOM SECTION END
                Item{
                    height: 100
                }
            }   // Central column END

            Item {
                id: rightVerticalSpacer
                width: 4
            }

            RowLayout {
                id: rowLayoutRight
                Layout.fillHeight: true
                Layout.minimumWidth: 200

                RectangularGlow {
                    id: effectRightColumn
                    glowRadius: 1
                    spread: 0.3
                    color: sideColors
                    cached: false
                    z: -1
                    opacity: sideOpacity
                    cornerRadius: 4
                    anchors.fill: parent
                }

                Item {
                    id: item5
                    width: 2
                }                

                ColumnLayout {                    

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item {
                        id: topSpacerRightColumn
                        height: 1
                    }

                    Button {
                        id: stopEverything


                        RectangularGlow {
                            id: effectStopEverything
                            glowRadius: 10
                            spread: 0.2
                            color: transparentBackgraoundClr
                            cached: false
                            z: -1
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }


                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop


                        background: Rectangle {
                            color: "#ff2233"
                            implicitWidth: parent
                            implicitHeight: 100
                            opacity: enabled ? 0.8 : 0.3
                            border.color: stopEverything.down ? "#660000" : "#375056"
                            border.width: 1
                            radius: 3
                        }

                        contentItem: Text {
                            text: "<b>STOP</b><"
                            font.pixelSize: 22
                            style: stopEverything.down ? Text.Outline : Text.Normal
                            styleColor: "#660000"
                            opacity: 1.0
                            color: stopEverything.down ? "#ffeeee" : "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                    }

                    Item {
                        id: rightButtonsColumnMidSpacer
                        Layout.minimumHeight: 50
                        Layout.maximumHeight: 500
                        Layout.fillHeight: true
                    }

                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                    Switch {
                        id: switchReactorIgnition
                        text: qsTr("Reactor Ignition ON/OFF")
                        checked: comm.isIgnitionSwitchOn

                    }

                    Switch {
                        id: switchFlareIgnition
                        text: qsTr("Flare Ignition ON/OFF")
                        checked: comm.isFlareIgnitionSwitchOn
                    }

                    Switch {
                        id: switchWaterPump
                        text: qsTr("Water Pump ON/OFF")
                        checked: comm.isWaterSwitchOn
                    }

                    Switch {
                        id: switchFANS
                        text: qsTr("FANS ON/OFF")
                        checked: comm.isFansSwitchOn
                    }


                    Item {
                        id: rightButtonsColumnBottomSpacer
                        Layout.maximumHeight: 280
                        Layout.minimumHeight: 150
                        Layout.fillHeight: true
                    }

                    Button {
                        id: beginStartSequence

                        RectangularGlow {
                            id: effectStartSequence
                            glowRadius: 10
                            spread: 0.2
                            color: transparentBackgraoundClr
                            cached: false
                            z: -1
                            opacity: transparentBackgraoundOpacity
                            cornerRadius: 4
                            anchors.fill: parent
                        }

                        text: "Begin <b>START</b> sequence"
                        enabled: !comm.startSequenceExecuting
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop


                        background: Rectangle {
                            color: "#2299ff"
                            implicitWidth: parent
                            implicitHeight: 100
                            opacity: enabled ? 1 : 0.1
                            border.color: beginStartSequence.down ? "#000000" : "#375056"
                            border.width: 1
                            radius: 3
                        }
                    }

                    Item {
                        id: bottomSpacerRightColumn
                        height: 1
                    }
                }

                Item {
                    id: rightScreenMarginSpacer
                    width: 1
                }

            }



            
        }

    }

}
