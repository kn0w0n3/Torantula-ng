import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.Material 2.12
//import QtQuick.Controls.Styles 1.4
//import QtQml.Models 2.12
import QtGraphicalEffects 1.12

Window {
    id: masterWin
    width: 800
    height: 500
    visible: true
    maximumWidth: 1280
    maximumHeight: 720
    title: qsTr("TORantula-ng")

    Timer {
        id: dateTimer
        interval: 1000
        repeat: true
        running: true
        property var locale: Qt.locale()
        property date currentDate: new Date()
        property string dateString
        onTriggered:{
            mwq_CurDateTxt.text = currentDate.toLocaleDateString(locale, Locale.ShortFormat);
            mws_CurDateTxt.text = currentDate.toLocaleDateString(locale, Locale.ShortFormat);
        }
    }

    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered:{
            mwq_CurTimeTxt.text =  Qt.formatTime(new Date(),"hh:mm:ss")
            mws_CurTimeTxt.text =  Qt.formatTime(new Date(),"hh:mm:ss")
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
            //comboBox1.currentIndex = mws_LogText.lineCount

           //Make the log data text in the terminal window auto scroll
           //indexTestText.text = mws_ScrollViewLogData.ScrollBar.vertical.size
           mws_ScrollViewLogData.ScrollBar.vertical.position = 1.0 - mws_ScrollViewLogData.ScrollBar.vertical.size
           mwq_ScrollVLogData.ScrollBar.vertical.position = 1.0 - mwq_ScrollVLogData.ScrollBar.vertical.size
        }
        onSpiderStatusStartedToQml: {
            mws_StatusText.visible = true
            //mws_RunSpiderBtn.enabled = false
        }
        onSpiderStatusStoppedToQml: {
            mws_StatusText.visible = false
        }
        onScanLogStatusStartedToQml: {
           mws_StatusText.visible = true
        }
        onScanLogStatusStoppedToQml: {
            mws_StatusText.visible = false
        }
    }

    Connections {
        target: mainController

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

            Text {
                id: indexTestText
                x: 58
                y: 452
                width: 75
                height: 19
                visible: false
                color: "#7711f4"
                text: qsTr("index")
                font.pixelSize: 12
                minimumPixelSize: 10
            }

            ComboBox {
                id: control
                x: 121
                y: 81
                width: 116
                height: 21
                model: ["Select Spider", "Dark Spider", "Clear Spider", "Crazy Spider"]

                delegate: ItemDelegate {
                    width: control.width
                    contentItem: Text {
                        text: control.textRole
                            ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole])
                            : modelData
                        color: "#7711f4" //Change the text color of the model data in the drop down box.
                        font: control.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: control.highlightedIndex === index
                }

                indicator: Canvas {
                    id: canvas
                    x: control.width - width - control.rightPadding
                    y: control.topPadding + (control.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"

                    Connections {
                        target: control
                        function onPressedChanged() { canvas.requestPaint(); }
                    }

                    //This will change the color of the triangle indicator.
                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = control.pressed ? "#7711f4" : "#7711f4";
                        context.fill();
                    }
                }
                //The second color is the main color. The first item is what color the changes to once clicked.
                //This will change the text color of main text in the box.
                contentItem: Text {
                    leftPadding: 0
                    rightPadding: control.indicator.width + control.spacing

                    text: control.displayText
                    font: control.font
                    color: control.pressed ? "#7711f4" : "#7711f4"
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                //This will change the main box background color, border color,  and the border color when pressed.
                //The second color is the main color. The first item is what color the changes to once clicked.
                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    color: "#000000"
                    border.color: control.pressed ? "#7711f4" : "#7711f4"
                    border.width: control.visualFocus ? 2 : 1
                    radius: 2
                }

                popup: Popup {
                    y: control.height - 1
                    width: control.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: control.popup.visible ? control.delegateModel : null
                        currentIndex: control.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    //This will change the color of the drop down Rectangle
                    background: Rectangle {
                        border.color: "#7711f4"
                        color: "#000000"
                        radius: 5
                    }
                }
            }
        }

        Label {
            id: mws_WindowViewNavLabel
            x: 331
            y: 89
            width: 139
            height: 20
            color: "#7711f4"
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
            palette.buttonText: "#7711f4"
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
            palette.buttonText: "#7711f4"

            onClicked: {
                if(mws_StatusText.visible == false){
                    mainController.startSpiderThread()
                }

                //mws_RunSpiderBtn.enabled = false

                if (mws_RunSpiderRect.visible == false){
                    mws_RunSpiderRect.visible = true
                }
                if(mws_LogDataRect.visible == true){
                    mws_LogDataRect.visible = false
                }
                mws_WindowViewNavLabel.text = "Run Spider | Data"
                mws_SpiderText.text += "Starting Spider.... " + " | " + mwq_CurTimeTxt.text + " | " + mwq_CurDateTxt.text + "\n"
                mwq_SpiderText.text += "Starting Spider.... " + " | " + mwq_CurTimeTxt.text + " | " + mwq_CurDateTxt.text + "\n"
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
            palette.buttonText: "#7711f4"
            onClicked: {
                if (mws_RunSpiderRect.visible == true){
                    mws_RunSpiderRect.visible = false
                }
                if(mws_LogDataRect.visible == false){
                    mws_LogDataRect.visible = true
                }
                mainController.startScanLogThread()
                mws_WindowViewNavLabel.text = "View Log | Data"
                mwq_LogText.text += "Opening Logs.... " + " | " + mwq_CurTimeTxt.text + " | " + mwq_CurDateTxt.text + "\n"
                mws_LogText.text += "Opening Logs.... " + " | " + mwq_CurTimeTxt.text + " | " + mwq_CurDateTxt.text + "\n"
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
            palette.buttonText: "#7711f4"
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
            palette.buttonText: "#7711f4"
            layer.enabled: true

            onClicked: {
                mainWinSingle.visible = false
                masterWin.width = 1280
                masterWin.height = 720
                mainWinQuad.visible = true
                //masterWinBg.visible = true
                //mwq_CurTimeTxt.visible = true
                //mwq_CurDateTxt.visible = true
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
            color: "#7711f4"
            text: qsTr("Processing......")
            font.pixelSize: 12
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
            //color: "#ffffff"
            //border.color: "#ffffff"
            ScrollView {
                id: mws_ScrollViewLogData
                x: 4
                y: 5
                width: 546
                height: 229
                enabled: true
                focusPolicy: Qt.NoFocus
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.vertical.position: 0
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

        Rectangle {
            id: mws_RunSpiderRect
            x: 121
            y: 110
            width: 558
            height: 234
            color: "#000000"
            border.color: "#7711f4"
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
                    color: "#1bf548"
                    wrapMode: Text.Wrap
                    clip: true
                    textFormat: Text.PlainText
                }
                enabled: true
            }
        }

        Text {
            id: mws_StatusTextLog
            x: 597
            y: 89
            width: 82
            height: 15
            visible: false
            color: "#7711f4"
            text: qsTr("Processing......")
            font.pixelSize: 12
        }

        Text {
            id: mws_CurDateTxt
            x: 725
            y: 29
            width: 64
            height: 15
            visible: true
            color: "#7711f4"
            text: qsTr("")
            font.pixelSize: 16
        }

        Text {
            id: mws_CurTimeTxt
            x: 728
            y: 8
            width: 64
            height: 15
            visible: true
            color: "#7711f4"
            text: ""
            font.pixelSize: 16
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


        Image {
            id: masterWinBg
            x: 0
            y: 0
            width: 1280
            height: 720
            visible: true
            source: "images/Torantula-bg-1280-720-dark80.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: mwq_RunSpiderRect
            x: 54
            y: 79
            width: 558
            height: 234
            color: "#000000"
            border.color: "#7711f4"

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
            x: 51
            y: 332
            width: 140
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
            palette.buttonText: "#7711f4"
            layer.enabled: true

            onClicked: {
                mainController.startSpiderThread()
            }
        }

        Button {
            id: mwq_ViewLogBtn
            x: 663
            y: 332
            width: 140
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
            palette.buttonText: "#7711f4"
            layer.enabled: true

            onClicked: {
                logDataProcessText.visible = true
                mainController.startScanLogThread()
            }
        }

        Button {
            id: clearSpiderWinBtn
            x: 264
            y: 332
            width: 140
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
            palette.buttonText: "#7711f4"
            layer.enabled: true
        }

        Rectangle {
            id: mwq_LogRect
            x: 663
            y: 79
            width: 558
            height: 234
            color: "#000000"
            border.color: "#7711f4"

            ScrollView {
                id: mwq_ScrollVLogData
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
            id: runSpiderWinLabel
            x: 276
            y: 65
            width: 92
            height: 15
            color: "#7711f4"
            text: qsTr("Run Spider Data")
            font.pixelSize: 12
        }

        Text {
            id: logDataLabel
            x: 910
            y: 65
            width: 65
            height: 15
            color: "#7711f4"
            text: qsTr("Log Data")
            font.pixelSize: 12
        }

        Text {
            id: runSpiderProcessingText
            x: 535
            y: 93
            width: 82
            height: 15
            visible: false
            color: "#7711f4"
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
            color: "#7711f4"
            text: qsTr("Processing......")
            font.pixelSize: 12
        }

        Button {
            id: clearLogWinBtn
            x: 885
            y: 332
            width: 140
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
            palette.buttonText: "#7711f4"
        }

        Button {
            id: mwq_SingleWinBtn
            x: 14
            y: 13
            width: 100
            height: 30
            visible: true
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
            palette.buttonText: "#7711f4"
            layer.enabled: true

            onClicked: {
                masterWin.width = 800
                masterWin.height = 500
                mainWinQuad.visible = false
                mainWinSingle.visible = true
                //mwq_CurTimeTxt.visible = false
                //mwq_CurDateTxt.visible = false
                //masterWinBg.visible = false
                mws_QuadBtn.visible = true
                mwq_SingleWinBtn.visible = false
            }
        }

        ComboBox {
            id: control2
            x: 54
            y: 52
            width: 116
            height: 21
            model: ["Select Spider", "Dark Spider", "Clear Spider", "Crazy Spider"]

            delegate: ItemDelegate {
                width: control2.width
                contentItem: Text {
                    text: control2.textRole
                        ? (Array.isArray(control2.model) ? modelData[control2.textRole] : model[control.textRole])
                        : modelData
                    color: "#7711f4" //Change the text colr of the model data in the drop down box.
                    font: control2.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: control2.highlightedIndex === index
            }

            indicator: Canvas {
                id: canvas2
                x: control2.width - width - control2.rightPadding
                y: control2.topPadding + (control2.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: control2
                    function onPressedChanged() { canvas.requestPaint(); }
                }

                //This will change the color of the triangle indicator.
                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = control.pressed ? "#7711f4" : "#7711f4";
                    context.fill();
                }
            }
            //The second color is the main color. The first item is what color the changes to once clicked.
            //This will change the text color of main text in the box.
            contentItem: Text {
                leftPadding: 0
                rightPadding: control2.indicator.width + control2.spacing

                text: control2.displayText
                font: control2.font
                color: control2.pressed ? "#7711f4" : "#7711f4"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            //This will change the main box background color, border color,  and the border color when pressed.
            //The second color is the main color. The first item is what color the changes to once clicked.
            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                color: "#000000"
                border.color: control2.pressed ? "#7711f4" : "#7711f4"
                border.width: control2.visualFocus ? 2 : 1
                radius: 2
            }

            popup: Popup {
                y: control2.height - 1
                width: control2.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: control2.popup.visible ? control2.delegateModel : null
                    currentIndex: control2.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                //This will change the color of the drop down Rectangle
                background: Rectangle {
                    border.color: "#7711f4"
                    color: "#000000"
                    radius: 5
                }
            }
        }

        Rectangle {
            id: mwq_RunPprocRect
            x: 54
            y: 419
            width: 558
            height: 234
            color: "#000000"
            border.color: "#7711f4"
            ScrollView {
                id: mwq_scrollVPprocess
                x: 4
                y: 5
                width: 546
                height: 223
                enabled: true
                focusPolicy: Qt.NoFocus
                TextArea {
                    id: mwq_PProcessText
                    x: -10
                    y: -6
                    width: 551
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    clip: true
                }
            }
        }

        Rectangle {
            id: mwq_RunGrapherRect
            x: 664
            y: 419
            width: 558
            height: 234
            color: "#000000"
            border.color: "#7711f4"
            ScrollView {
                id: mwq_ScrollVGrapher
                x: 4
                y: 5
                width: 546
                height: 223
                enabled: true
                focusPolicy: Qt.NoFocus
                TextArea {
                    id: mwq_GrapherText
                    x: -10
                    y: -6
                    width: 551
                    height: 223
                    color: "#16e23c"
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    clip: true
                }
            }
        }

        Text {
            id: runPProcessorLabel
            x: 294
            y: 402
            width: 78
            height: 17
            color: "#7711f4"
            text: qsTr("Preprocessor")
            font.pixelSize: 12
        }

        Text {
            id: runSpiderWinLabel1
            x: 918
            y: 402
            width: 51
            height: 17
            color: "#7711f4"
            text: qsTr("Grapher")
            font.pixelSize: 12
        }

        Button {
            id: runPreprocessorBtn
            x: 52
            y: 667
            width: 140
            height: 34
            visible: true
            text: qsTr("Run Preprocessor")
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                samples: 17
                verticalOffset: 2
                transparentBorder: true
                spread: 0
            }
            palette.buttonText: "#7711f4"
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
        }

        Button {
            id: runGrapherBtn
            x: 664
            y: 667
            width: 140
            height: 34
            text: qsTr("Run Grapher")
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                samples: 17
                verticalOffset: 2
                transparentBorder: true
                spread: 0
            }
            palette.buttonText: "#7711f4"
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
        }

        Button {
            id: clearPprocessorWinBtn
            x: 265
            y: 667
            width: 140
            height: 34
            visible: true
            text: qsTr("Clear")
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                samples: 17
                verticalOffset: 2
                transparentBorder: true
                spread: 0
            }
            palette.buttonText: "#7711f4"
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
        }

        Button {
            id: clearGrapherWinBtn
            x: 886
            y: 667
            width: 140
            height: 34
            visible: true
            text: qsTr("Clear")
            layer.effect: DropShadow {
                width: 69
                color: "#7711f4"
                radius: 8
                horizontalOffset: 2
                samples: 17
                verticalOffset: 2
                transparentBorder: true
                spread: 0
            }
            palette.buttonText: "#7711f4"
            background: Rectangle {
                color: "#161e20"
                radius: 50
            }
            layer.enabled: true
        }

        Text {
            id: mwq_CurDateTxt
            x: 1211
            y: 25
            width: 64
            height: 15
            visible: true
            color: "#7711f4"
            text: qsTr("")
            font.pixelSize: 16
        }

        Text {
            id: mwq_CurTimeTxt
            x: 1212
            y: 5
            width: 64
            height: 15
            visible: true
            color: "#7711f4"
            text: ""
            font.pixelSize: 16
        }

    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:42}D{i:46}D{i:72}D{i:83}D{i:86}D{i:89}D{i:90}
}
##^##*/
