import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.Styles 1.4
//import QtQml.Models 2.12
//import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12

Window {
    width: 800
    height: 500
    visible: true
    maximumWidth: 800
    maximumHeight: 500
    title: qsTr("Torantula-ng")

    Image {
        id: image
        x: 0
        y: 0
        width: 800
        height: 500
        source: "images/Torantula-bg.png"
        fillMode: Image.PreserveAspectFit
    }

    Timer {
        id: dateTimer
        interval: 1000
        repeat: true
        running: true
        property var locale: Qt.locale()
        property date currentDate: new Date()
        property string dateString
        onTriggered:{
            curDateTxt.text = currentDate.toLocaleDateString(locale, Locale.ShortFormat);
        }
    }

    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered:{
            curTimeTxt.text =  Qt.formatTime(new Date(),"hh:mm:ss")
        }
    }

    Text {
        id: curTimeTxt
        x: 732
        y: 5
        width: 64
        height: 15
        color: "#ffffff"
        text: ""
        font.pixelSize: 16
    }

    Text {
        id: curDateTxt
        x: 735
        y: 25
        width: 64
        height: 15
        color: "#ffffff"
        text: qsTr("")
        font.pixelSize: 16
    }


    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 800
        height: 500
        color: "#00ffffff"

        Rectangle {
            id: rectangle1
            x: 194
            y: 87
            width: 413
            height: 234
            color: "#000000"
            border.color: "#ffffff"
        }

        Button {
            id: button
            x: 194
            y: 341
            width: 100
            height: 34
            text: qsTr("Spider")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                transparentBorder: true
                horizontalOffset: 2
                spread: 0
                samples: 17
            }
            palette.buttonText: "#ffffff"
            layer.enabled: true
        }

        Button {
            id: button1
            x: 350
            y: 341
            width: 100
            height: 34
            text: qsTr("Tail")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                transparentBorder: true
                horizontalOffset: 2
                spread: 0
                samples: 17
            }
            palette.buttonText: "#ffffff"
            layer.enabled: true
        }

        Button {
            id: button2
            x: 507
            y: 341
            width: 100
            text: qsTr("Dataset")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                transparentBorder: true
                horizontalOffset: 2
                spread: 0
                samples: 17
            }
            palette.buttonText: "#ffffff"
            layer.enabled: true
        }

        Button {
            id: button3
            x: 194
            y: 415
            width: 100
            height: 34
            text: qsTr("Execute")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                transparentBorder: true
                horizontalOffset: 2
                spread: 0
                samples: 17
            }
            palette.buttonText: "#ffffff"
            layer.enabled: true
        }

        Rectangle {
            id: rectForTextEdit
            x: 303
            y: 427
            width: 307
            height: 18
            color: "#000000"
            border.color: "#ffffff"
        }
    }


}


