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
    width: 400
    height: 400

    property alias line1: line1
    property alias line2: line2
    property alias line3: line3

    ChartView {
        title: "Line"
        anchors.fill: parent
        antialiasing: true

        LineSeries {
            id: line1
            name: "LineSeries1"
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

    }
    line1.onClicked: {
        line3.append(2, 2);
    }
    line2.onClicked: {
        line3.append(5, 3);
    }




}
