#include "maincontroller.h"

MainController::MainController(QObject *parent) : QObject(parent){
    //runSpider();
}

void MainController::runSpider(void){

    /*EXAMPLE
    QProcess *runWireshark = new QProcess();
    QString programPath = "/usr/bin/gnome-terminal";
    runWireshark->start(programPath);
    */
    //scrapy genspider example example.com
    //scrapy genspider spiderX1 quotes.toscrape.com
    /*
    qDebug() << "Trying to  run SPider.......";

    QProcess proc;
    proc.start("/bin/sh", QStringList() << "/home/voldem0rt/Desktop/run-spiders.sh", QIODevice::ReadWrite);

    proc.waitForFinished();

    QByteArray output = proc.readAll();
    QString outputAsString = QString(output);
    //QString textToRemove = "/usr/local/lib/python2.7/dist-packages/OpenSSL/crypto.py:14: CryptographyDeprecationWarning: Python 2 is no longer supported by the Python core team. Support for it is now deprecated in cryptography, and will be removed in the next release.\n  from cryptography import utils, x509\n/usr/local/lib/python2.7/dist-packages/OpenSSL/crypto.py:14: CryptographyDeprecationWarning: Python 2 is no longer supported by the Python core team. Support for it is now deprecated in cryptography, and will be removed in the next release.\n  from cryptography import utils, x509\n";
    //outputAsString.replace(textToRemove, "");
    QByteArray errorOutput = proc.readAllStandardError();
    QByteArray outputStandard = proc.readAllStandardOutput();

    qDebug() << "Read all output is: " << output;
    qDebug() << "String output is: " << outputAsString;
    qDebug() << "Read error output is: " << errorOutput;
    qDebug() << "Read all standard output is: " << outputStandard;
    scrapyData = QString(output);
    scrapyErrorData = QString(errorOutput);
    proc.close();
    emit scrapyDataToQml(scrapyData);
    //emit scrapyDataToQml(scrapyErrorData);
    */


}

//Start the scan log thread
void MainController::startScanLogThread(){
    logThread = new LogThread();
    //connect(logThread, &LogThread::scanLogStatus, this, &MainController::scanLogStatus);
    //connect(logThread, &LogThread::scanLogStopped, this, &MainController::scanLogStatus);
    connect(logThread, &LogThread::streamingLogData, this, &MainController::scanLogStreamDataRelay);
    //connect(logThread, &LogThread::scannedFileNumS, this, &MainController::handleScanOpsInfo);

    connect(logThread, &LogThread::finished, logThread, &QObject::deleteLater);

    logThread ->start();
}

void MainController::startSpiderThread(){
    runSpiderThread = new RunSpiderThread();
    connect(runSpiderThread, &RunSpiderThread::spiderRunStatus, this, &MainController::spiderStatusRelay);
    connect(runSpiderThread, &RunSpiderThread::scrapyConsoleData, this, &MainController::spiderThreadDataRelay);
    //connect(runSpiderThread, &RunSpiderThread::streamingLogData, this, &MainController::scanLogStreamDataRelay);
    //connect(logThread, &LogThread::scannedFileNumS, this, &MainController::handleScanOpsInfo);

    connect(runSpiderThread , &RunSpiderThread::finished, runSpiderThread, &QObject::deleteLater);
    runSpiderThread->start();
    }

void MainController::spiderThreadDataRelay(QString spiderData){
    qDebug() << "Spiderdata in relay is..."<< spiderData;
    emit scrapyCliDataToQml(spiderData);
}

void MainController::spiderStatusRelay(QString spiderStatus){
    if(spiderStatus == "started"){
        emit spiderStatusStartedToQml();
    }
    else if(spiderStatus == "stopped"){
        emit spiderStatusStoppedToQml();
    }
}

//Receive status of the scan log from the thread
void MainController::scanLogStatus(QString lStatData){
    if(lStatData == "started"){
        emit scanLogStatusStartedToQml();
    }
    else if(lStatData == "stopped"){
        //emit scanLogStatusStoppedToQml();
    }
}

//Receive the scan log data from the thread and pass it to QML
void MainController::scanLogStreamDataRelay(QString dStream){
    emit scrapyLogDataToQml(dStream);
}
