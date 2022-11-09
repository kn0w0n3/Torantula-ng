#include "logthread.h"

LogThread::LogThread(QThread *parent) : QThread(parent){

}

void LogThread::run() {
    emit scanLogStatus("started");

    sleep(5); // block for x seconds

    QFile scanInputFile("/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/scanLog.log");
    if (scanInputFile.open(QIODevice::ReadOnly)) {
        qDebug() << "In file read funtion";
        QTextStream in(&scanInputFile);
        while (!in.atEnd()) {

            lineX = in.readLine() + "\n\n";
            sleep(5);
            emit streamingLogData(lineX);
            sleep(5);
        }
        scanInputFile.close();
    }
    emit scanLogStatus("stopped");
}

void LogThread::getRequiredFiles(){

}


