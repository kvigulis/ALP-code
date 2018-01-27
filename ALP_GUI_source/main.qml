import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2





ApplicationWindow {

    id: mainWindow
    visible: true
    width: 1366
    height: 768
    title: qsTr("ALP Power Alpha V1.09   ")
    minimumWidth: 1400
    minimumHeight: 755

    //visibility: Window.FullScreen


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {

        }

        Page2 {

        }

        Page3 {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Monitor and Control Panel")
        }
        TabButton {
            text: qsTr("Automation Settings")
        }
        TabButton {
            text: qsTr("Statistics")
        }
    }
}
