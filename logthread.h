#ifndef LOGTHREAD_H
#define LOGTHREAD_H

#include <QThread>
#include <QObject>
//#include <QFileDialog>
#include <QFile>
#include <QCoreApplication>
//#include <QStringListIterator>
//#include <QCryptographicHash>
//#include <QListIterator>
#include <QTextStream>
#include <QDebug>
#include <QTimer>

class LogThread: public QThread{
    Q_OBJECT

public:
    LogThread(QThread *parent = 0);
    void run();

    ~LogThread() {
        wait(); // important: It's illegal to destruct a running thread!
      }

signals:
    void scanLogStatus(QString);
    //void scanLogStopped(QString);
    void streamingLogData(QString);
     //void scannedFileNumS(QString);

public slots:
    void getRequiredFiles();

private:
    //QStringList virusList;
    //int hashType;
    //QByteArray hashDataMd5;
    //QStringList hashList;
    QString fileName;
    QString filePath;
    QString lineX;
    QTextStream textStreamOne;
    //int numScannedFiles;

};

#endif // LOGTHREAD_H
