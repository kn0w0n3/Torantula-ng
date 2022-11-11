import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.Styles 1.4
//import QtQml.Models 2.12
//import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12

Window {
    id: masterWin
    width: 800
    height: 500
    visible: true
    maximumWidth: 1280
    maximumHeight: 720
    title: qsTr("TORantula-ng")

    Image {
        id: masterWinBg
        x: 0
        y: 0
        width: 1280
        height: 720
        visible: false
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

    /*Connections for receiving data from C++ classes.
      Even though the signals start with a lowercase letter
      in the class, the first letter of the signal name from
      the C++ class must be capitalized here after the keyword "on".
      For example: The signal name: "scrapyCliDataToQml" from the C++ class
      MainController would need to be changed to "ScrapyCliDataToQml" here.
      For the connection, you have to use the on keyword like this: onScrapyCliDataToQml.
      So, two things are happening here; add on for the connection and capitalize the first
      letter of the signal name from the C++ class.If you make the first letter capital  in the class,
      it will break here.*/

    Connections {
        target: mainController
        onScrapyCliDataToQml: {
            mwq_SpiderText.text += scrapyCliData_1
            mws_SpiderText.text += scrapyCliData_1
        }
        onScrapyLogDataToQml: {
            mwq_LogText.text += scanLogData_1
            mws_LogText.text += scanLogData_1
        }
        onSpiderStatusStartedToQml: {
            mws_StatusText.visible = true
            //mws_RunSpiderBtn.enabled = false
        }
        onSpiderStatusStoppedToQml: {
            mws_StatusText.visible = false
           //runSpiderProcessingText.visible = false
            //mws_RunSpiderBtn.enabled = true
        }
        onScanLogStatusStartedToQml: {
           //logDataProcessText.visible = true
           //runSpiderProcessingText.visible = true
           mws_StatusText.visible = true
        }
        onScanLogStatusStoppedToQml: {
            mws_StatusText.visible = false
           //logDataProcessText.visible = false
          // runSpiderProcessingText.visible = false
        }
    }

    Connections {
        target: mainController

    }
    Text {
        id: curTimeTxt
        x: 1212
        y: 5
        width: 64
        height: 15
        visible: false
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
        visible: false
        color: "#ffffff"
        text: qsTr("")
        font.pixelSize: 16
    }

    Rectangle {
        id: mainWinSingle
        x: 0
        y: 0
        width: 800
        height: 500
        visible: true
        color: "#00ffffff"


        Image {
            id: mws_backgroundImg
            x: 0
            y: 0
            width: 800
            height: 500
            source: "images/Torantula-bg3.png"
            fillMode: Image.PreserveAspectFit
        }


        Rectangle {
            id: mws_LogDataRect
            x: 121
            y: 110
            width: 558
            height: 234
            visible: false
            color: "#000000"
            border.color: "#ffffff"
            ScrollView {
                id: mws_ScrollViewLogData
                x: 4
                y: 5
                width: 546
                height: 223
                enabled: true
                focusPolicy: Qt.NoFocus
                TextArea {
                    id: mws_LogText
                    x: -10
                    y: -6
                    width: 546
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    clip: true

                    textFormat: Text.PlainText
                }
            }
        }

        ComboBox {
            id: comboBox1
            x: 121
            y: 78
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
                    text: "Dark Spider"
                }

                ListElement {
                    text: "Clear Spider"
                }

                ListElement {
                    text: "CrazySpider"
                }
            }
            flat: true
            font.pointSize: 8
            editable: false
        }
        Label {
            id: mws_WindowViewNavLabel
            x: 331
            y: 89
            width: 139
            height: 20
            color: "#ffffff"
            font.underline: false
            font.italic: false
            font.bold: false
            font.pointSize: 12
        }
        Button {
            id: mws_PprocessBtn
            x: 412
            y: 365
            width: 115
            height: 34
            text: qsTr("Pre-Processor")
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
                mws_WindowViewNavLabel.text = "Pre-processor | Data"
            }
        }
        Button {
            id: mws_RunSpiderBtn
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

            onClicked: {
                mainController.startSpiderThread()
                mws_RunSpiderBtn.enabled = false

                if (mws_RunSpiderRect.visible == false){
                    mws_RunSpiderRect.visible = true
                }
                if(mws_LogDataRect.visible == true){
                    mws_LogDataRect.visible = false
                }
                mws_WindowViewNavLabel.text = "Run Spider | Data"
                mws_SpiderText.text += "Starting Spider.... " + " | " + curTimeTxt.text + " | " + curDateTxt.text + "\n"
                mwq_LogText.text += "Starting Spider.... " + " | " + curTimeTxt.text + " | " + curDateTxt.text + "\n"
            }
        }
        Button {
            id: mws_ViewLogBtn
            x: 268
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
                if (mws_RunSpiderRect.visible == true){
                    mws_RunSpiderRect.visible = false
                }
                if(mws_LogDataRect.visible == false){
                    mws_LogDataRect.visible = true
                }
                mainController.startScanLogThread()
                mws_WindowViewNavLabel.text = "View Log | Data"
            }
        }

        Button {
            id: mws_GrapherBtn
            x: 564
            y: 365
            width: 115
            height: 34
            text: qsTr("Grapher")
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                horizontalOffset: 2
                transparentBorder: true
                spread: 0
                samples: 17
            }
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
            palette.buttonText: "#ffffff"
            onClicked: {
                mws_WindowViewNavLabel.text = "Grapher | Data"
            }
        }

        Button {
            id: mws_QuadBtn
            x: 14
            y: 13
            width: 100
            height: 30
            visible: true
            text: qsTr("View Quad")
            font.pointSize: 10
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
                mainWinSingle.visible = false
                masterWin.width = 1280
                masterWin.height = 720
                mainWinQuad.visible = true
                masterWinBg.visible = true
                curTimeTxt.visible = true
                curDateTxt.visible = true
                mws_QuadBtn.visible = false
                mwq_SingleWinBtn.visible = true
            }
        }

        Text {
            id: mws_StatusText
            x: 597
            y: 89
            width: 82
            height: 15
            visible: false
            color: "#ffffff"
            text: qsTr("Processing......")
            font.pixelSize: 12
        }
        Rectangle {
            id: mws_RunSpiderRect
            x: 121
            y: 110
            width: 558
            height: 234
            color: "#000000"
            border.color: "#ffffff"
            ScrollView {
                id: mws_runSpiderScrollView
                x: 4
                y: 5
                width: 546
                height: 223
                focusPolicy: Qt.NoFocus
                TextArea {
                    id: mws_SpiderText
                    x: -10
                    y: -6
                    width: 546
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    clip: true
                    textFormat: Text.PlainText
                }
                enabled: true
            }
        }
    }

    Rectangle {
        id: mainWinQuad
        x: 0
        y: 0
        width: 1280
        height: 720
        visible: false
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
                //ScrollBar.vertical.position: scrollPosition

                TextArea {
                    id: mwq_SpiderText
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
                mainController.startSpiderThread()
            }
        }

        Button {
            id: mwq_ViewLogBtn
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
                //ScrollBar.vertical.position: ScrollBar.setPosition(100)
                TextArea {
                    id: mwq_LogText
                    x: -10
                    y: -6
                    width: 552
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText                   
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
            visible: true
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

        Button {
            id: mwq_SingleWinBtn
            x: 14
            y: 13
            width: 100
            height: 30
            visible: false
            text: qsTr("View Single")
            font.pointSize: 10
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                verticalOffset: 2
                horizontalOffset: 2
                transparentBorder: true
                spread: 0
                samples: 17
            }
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            palette.buttonText: "#ffffff"
            layer.enabled: true

            onClicked: {
                masterWin.width = 800
                masterWin.height = 500
                mainWinQuad.visible = false
                mainWinSingle.visible = true
                curTimeTxt.visible = false
                curDateTxt.visible = false
                masterWinBg.visible = false
                mws_QuadBtn.visible = true
                mwq_SingleWinBtn.visible = false
            }
        }
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:35}
}
##^##*/
