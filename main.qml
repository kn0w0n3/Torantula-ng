import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.Styles 1.4
//import QtQml.Models 2.12
//import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12

Window {
    width: 1280
    height: 720
    visible: true
    maximumWidth: 1280
    maximumHeight: 720
    title: qsTr("TORantula-ng")

    Image {
        id: image
        x: 0
        y: 0
        width: 1280
        height: 720
        source: "images/Torantula-bg-1280-720-dark80.png"
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

    Connections {
        target: mainController
        onSpiderStatusStartedToQml: {
           runSpiderProcessingText.visible = true
        }
        onSpiderStatusStoppedToQml: {
           runSpiderProcessingText.visible = false
        }
        onScanLogStatusStartedToQml: {
           logDataProcessText.visible = true
        }
        onScanLogStatusStoppedToQml: {
           logDataProcessText.visible = false
        }
    }

    Text {
        id: curTimeTxt
        x: 1212
        y: 5
        width: 64
        height: 15
        color: "#ffffff"
        text: ""
        font.pixelSize: 16
    }


    Text {
        id: curDateTxt
        x: 1215
        y: 25
        width: 64
        height: 15
        color: "#ffffff"
        text: qsTr("")
        font.pixelSize: 16
    }

    Rectangle {
        id: detailsWin
        x: 0
        y: 0
        width: 1280
        height: 720
        visible: false
        color: "#00ffffff"

        Label {
            id: label
            x: 329
            y: 91
            width: 143
            height: 25
            color: "#ffffff"
            text: qsTr("Scrapy Log Data")
            font.underline: false
            font.italic: false
            font.bold: false
            font.pointSize: 14
        }

        Button {
            id: detailsWinBckBtn
            x: 14
            y: 13
            text: qsTr("Back")
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

            onClicked: {
                detailsWin.visible = false
                mainWin.visible = true
            }
        }

        Rectangle {
            id: rectangle2
            x: 121
            y: 114
            width: 558
            height: 234
            color: "#000000"
            border.color: "#ffffff"
            ScrollView {
                id: scrollView1
                x: 4
                y: 5
                width: 546
                height: 223
                focusPolicy: Qt.NoFocus
                TextArea {
                    id: scanLogTextArea
                    x: -10
                    y: -6
                    width: 546
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    clip: true
                    textFormat: Text.PlainText
                    Connections {
                        target: mainController
                        onScrapyLogDataToQml: {
                            //scanLogTextArea.text += scanLogData_1
                        }
                    }
                }
                enabled: true
            }
        }

        Button {
            id: viewScanLogBtn
            x: 343
            y: 365
            width: 115
            height: 34
            visible: true
            text: qsTr("View Log")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                spread: 0
                verticalOffset: 2
                transparentBorder: true
                samples: 17
            }
            palette.buttonText: "#ffffff"

            onClicked: {
                mainWin.visible = false
                detailsWin.visible = true
            }
        }

        Button {
            id: runSpiderBtn1
            x: 121
            y: 365
            width: 115
            height: 34
            visible: true
            text: qsTr("Run Spider")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                spread: 0
                verticalOffset: 2
                transparentBorder: true
                samples: 17
            }
            palette.buttonText: "#ffffff"
        }

        Button {
            id: button4
            x: 564
            y: 367
            width: 115
            text: qsTr("Help")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                spread: 0
                verticalOffset: 2
                transparentBorder: true
                samples: 17
            }
            palette.buttonText: "#ffffff"
        }

        Button {
            id: button5
            x: 121
            y: 431
            width: 115
            height: 34
            visible: false
            text: qsTr("Execute")
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                spread: 0
                verticalOffset: 2
                transparentBorder: true
                samples: 17
            }
            palette.buttonText: "#ffffff"
        }

        Rectangle {
            id: rectForTextEdit1
            x: 242
            y: 442
            width: 403
            height: 18
            visible: false
            color: "#000000"
            border.color: "#ffffff"
            TextEdit {
                id: textEdit1
                x: 2
                y: 442
                width: 401
                height: 12
                color: "#16e23c"
                text: qsTr("")
                font.pixelSize: 12
            }
        }

        ComboBox {
            id: comboBox1
            x: 121
            y: 81
            width: 115
            height: 27
            background: Rectangle {
                color: "#000000"
            }
            displayText: "Select Spider"
            rightPadding: 30
            model: ListModel {
                id: model1
                ListElement {
                    text: "OnionSpider"
                }

                ListElement {
                    text: "DarkSpider"
                }

                ListElement {
                    text: "CrazySpider"
                }
            }
            flat: true
            font.pointSize: 8
            editable: false
        }

    }

    Rectangle {
        id: mainWin
        x: 0
        y: 0
        width: 1280
        height: 720
        visible: true
        color: "#00ffffff"

        Rectangle {
            id: rectangle1
            x: 59
            y: 114
            width: 558
            height: 234
            color: "#000000"
            border.color: "#ffffff"

            ScrollView {
                id: scrollView
                x: 4
                y: 5
                width: 546
                height: 223
                focusPolicy: Qt.NoFocus
                enabled: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                TextArea {
                    id: runSpiderTextArea
                    x: -10
                    y: -6
                    width: 551
                    height: 223
                    //selectByMouse: true
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    clip: true
                    Component.onCompleted: {
                        //mainController.runSpider()
                    }
                    Connections {
                        target: mainController

                        onScrapyCliDataToQml: {
                            runSpiderTextArea.text += scrapyCliData_1
                        }
                    }
                }
            }
        }

        Button {
            id: runSpiderBtn
            x: 68
            y: 376
            width: 115
            height: 34
            visible: true
            text: qsTr("Run Spider")
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

            onClicked: {
                //runSpiderProcessingText.visible = true
                mainController.startSpiderThread()

                //mainController.startScanLogThread()
                //detailsWin.visible = vtrue
            }
        }

        Button {
            id: detailsBtn
            x: 675
            y: 376
            width: 115
            height: 34
            text: qsTr("View Log")
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

            onClicked: {
                //mainWin.visible = false
                //detailsWin.visible = true
                logDataProcessText.visible = true
                mainController.startScanLogThread()

            }
        }

        Button {
            id: clearSpiderWinBtn
            x: 281
            y: 376
            width: 115
            height: 34
            visible: true
            text: qsTr("Clear")
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
            x: 121
            y: 431
            width: 115
            height: 34
            visible: false
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
            x: 242
            y: 442
            width: 403
            height: 18
            visible: false
            color: "#000000"
            border.color: "#ffffff"

            TextEdit {
                id: textEdit
                x: 2
                y: 442
                width: 401
                height: 12
                color: "#16e23c"
                text: qsTr("")
                font.pixelSize: 12
            }
        }

        ComboBox {
            id: comboBox
            x: 59
            y: 81
            width: 115
            height: 27
            flat: true
            editable: false
            rightPadding: 30
            font.pointSize: 8
            displayText: "Select Spider"

            background: Rectangle {
                color:"black"
                //border.width: parent && parent.activeFocus ? 2 : 1
                // border.color: parent && parent.activeFocus ? comboBoxCustom.palette.highlight : comboBoxCustom.palette.button
            }

            model: ListModel {
                id: model

                ListElement {
                    text: "OnionSpider"
                }
                ListElement {
                    text: "DarkSpider"
                }
                ListElement {
                    text: "CrazySpider"
                }
            }

        }

        Rectangle {
            id: rectangle3
            x: 675
            y: 114
            width: 558
            height: 234
            color: "#000000"
            border.color: "#ffffff"

            ScrollView {
                id: scrollView2
                x: 4
                y: 5
                width: 546
                height: 223
                enabled: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                TextArea {
                    id: scrapyLogDataTextArea
                    x: -10
                    y: -6
                    width: 552
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    Connections {
                        target: mainController
                        onScrapyLogDataToQml: {
                            scrapyLogDataTextArea.text += scanLogData_1
                        }
                    }
                    clip: true
                }
                focusPolicy: Qt.NoFocus
            }
        }

        Text {
            id: text1
            x: 292
            y: 100
            width: 92
            height: 15
            color: "#ffffff"
            text: qsTr("Run Spider Data")
            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 908
            y: 100
            width: 92
            height: 15
            color: "#ffffff"
            text: qsTr("Scrapy Log Data")
            font.pixelSize: 12
        }

        Text {
            id: runSpiderProcessingText
            x: 535
            y: 93
            width: 82
            height: 15
            visible: false
            color: "#ffffff"
            text: qsTr("Processing......")
            font.pixelSize: 12
        }

        Text {
            id: logDataProcessText
            x: 1151
            y: 93
            width: 89
            height: 15
            visible: false
            color: "#ffffff"
            text: qsTr("Processing......")
            font.pixelSize: 12
        }

        Button {
            id: clearLogWinBtn
            x: 897
            y: 376
            width: 115
            height: 34
            visible: true
            text: qsTr("Clear")
            layer.enabled: true
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                samples: 17
                transparentBorder: true
                horizontalOffset: 2
                spread: 0
            }
            palette.buttonText: "#ffffff"
        }
    }



}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:28}D{i:69}
}
##^##*/
