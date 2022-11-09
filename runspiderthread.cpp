#include "runspiderthread.h"


RunSpiderThread::RunSpiderThread(QThread *parent) : QThread(parent){

}

void RunSpiderThread::run(){
    emit spiderRunStatus("started");
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
    emit scrapyConsoleData(scrapyData);
    //emit scrapyDataToQml(scrapyErrorData);
/*
    QFile scanInputFile("/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/scanLog.log");
    if (scanInputFile.open(QIODevice::ReadOnly)) {
        qDebug() << "In file read funtion";
        QTextStream in(&scanInputFile);
        while (!in.atEnd()) {

            QString line = in.readLine();
            emit scrapyConsoleData(line);
        }
        scanInputFile.close();
    }
    */
        emit spiderRunStatus("stopped");
}

void RunSpiderThread::getRequiredFiles(){

}
