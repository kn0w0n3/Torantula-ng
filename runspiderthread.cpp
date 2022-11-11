#include "runspiderthread.h"


RunSpiderThread::RunSpiderThread(QThread *parent) : QThread(parent){

}

void RunSpiderThread::run(){
    emit spiderRunStatus("started");
    msleep(100);
    qDebug() << "Trying to  run Spider.......";

    QProcess proc;
    proc.start("/bin/sh", QStringList() << "/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/"
                                           "spiders/start-dark-spider.sh", QIODevice::ReadWrite);
    proc.waitForFinished();

    QByteArray output = proc.readAll();
    msleep(100);
    QString outputAsString = QString(output);
    msleep(100);
    QByteArray errorOutput = proc.readAllStandardError();
    msleep(100);
    QByteArray outputStandard = proc.readAllStandardOutput();
    msleep(100);

    qDebug() << "Read all output is: " << output;
    qDebug() << "String output is: " << outputAsString;
    qDebug() << "Read error output is: " << errorOutput;
    qDebug() << "Read all standard output is: " << outputStandard;
    scrapyData = QString(output);
    scrapyErrorData = QString(errorOutput);
    proc.close();
    msleep(100);
    emit scrapyConsoleData(scrapyData);
    //msleep(100);
    emit spiderRunStatus("stopped");
}
