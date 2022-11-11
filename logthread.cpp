#include "logthread.h"

LogThread::LogThread(QThread *parent) : QThread(parent){

}

void LogThread::run() {
    emit scanLogStatus("started");

    msleep(100); // block for x seconds

    QFile scanInputFile("/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Clearscrape/Clearscrape/spiders/clearLogScan.log");
    if (scanInputFile.open(QIODevice::ReadOnly)) {
        qDebug() << "In file read funtion";
        QTextStream in(&scanInputFile);
        while (!in.atEnd()) {

            lineX = in.readLine() + "\n\n";
            msleep(100);
            emit streamingLogData(lineX);
            msleep(100);
        }
        scanInputFile.close();
    }
    emit scanLogStatus("stopped");
}


