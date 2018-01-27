import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0

import QtQuick.Controls.Styles 1.4

import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import QtCharts 2.2
import QtQuick.XmlListModel 2.0




Item {
    id: frame3
    width: 1200
    height: 800

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        RowLayout {
            id: rowLayout
            anchors.fill: parent



            ColumnLayout {
                id: columnLayout
                width: 100
                height: 100
                Layout.minimumWidth: 250
                Layout.maximumWidth: 300
                Layout.fillWidth: true


                Item {
                    id: item1
                    width: 200
                    height: 200
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                    Layout.fillHeight: true
                }

                RowLayout {
                    id: rowLayout1
                    width: 100
                    height: 100
                    Layout.maximumHeight: 65535
                    Layout.fillHeight: false

                    Item {
                        id: item3
                        width: 200
                        height: 200
                        Layout.maximumHeight: 20
                        Layout.maximumWidth: 8
                        Layout.fillWidth: true
                    }

                    Button {
                        id: button
                        text: qsTr("Button")
                        Layout.minimumHeight: 40
                        Layout.maximumHeight: 40
                        Layout.fillHeight: false
                        Layout.maximumWidth: 300
                        Layout.fillWidth: true
                    }


                    Item {
                        id: item4
                        width: 200
                        height: 200
                        Layout.maximumHeight: 20
                        Layout.maximumWidth: 8
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    id: rowLayout2
                    width: 100
                    height: 100
                    Layout.maximumHeight: 50
                    Layout.fillWidth: true

                    Item {
                        id: item5
                        width: 200
                        height: 200
                        Layout.maximumHeight: 20
                        Layout.maximumWidth: 8
                    }

                    Button {
                        id: button1
                        text: qsTr("Button")
                        Layout.minimumHeight: 40
                        Layout.maximumHeight: 40
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    Button {
                        id: button2
                        text: qsTr("Button")
                        Layout.maximumHeight: 40
                        Layout.minimumHeight: 40
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    Item {
                        id: item6
                        width: 200
                        height: 200
                        Layout.maximumHeight: 20
                        Layout.maximumWidth: 8
                    }
                }

                Item {
                    id: item2
                    width: 200
                    height: 200
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }



            }

            ColumnLayout {
                id: columnLayout1
                width: 100
                height: 100
                Layout.fillWidth: true
            }



            ColumnLayout {
                id: columnLayout2
                width: 100
                height: 100
                Layout.fillWidth: true
            }
        }
    }

    /*property alias line1: line1
    property alias line2: line2
    property alias line3: line3

    ChartView {
        title: "Line"
        anchors.fill: parent
        antialiasing: true

        LineSeries {
            id: line1
            name: "LineSeries3"
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 12.1 }
            XYPoint { x: 1.9; y: 13.3 }
            XYPoint { x: 2.1; y: 12.1 }
            XYPoint { x: 2.9; y: 14.9 }
            XYPoint { x: 3.4; y: 13.0 }
            XYPoint { x: 4.1; y: 13.3 }
        }

        LineSeries {
            id: line2
            name: "LineSeries2"
            color : "#337777"
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 2.1 }
            XYPoint { x: 1.9; y: 3.3 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 4.9 }
            XYPoint { x: 3.4; y: 3.0 }
            XYPoint { x: 4.1; y: 3.3 }
        }
        LineSeries {
            id: line3
            name: "LineSeries3"
            XYPoint { x: 0; y: 0 }
        }

    }*/


}
