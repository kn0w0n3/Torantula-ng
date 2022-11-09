#ifndef RUNSPIDERTHREAD_H
#define RUNSPIDERTHREAD_H


#include <QThread>
#include <QObject>
//#include <QFileDialog>
#include <QProcess>
//#include <QStringListIterator>
//#include <QCryptographicHash>
//#include <QListIterator>
#include <QTextStream>
#include <QDebug>

class RunSpiderThread: public QThread{
    Q_OBJECT

public:
    RunSpiderThread(QThread *parent = 0);
    void run();
    //bool stopSingleThread;

signals:
    //void scanLogStarted(QString);
    void spiderRunStatus(QString);
    void scrapyConsoleData(QString);
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
    QString scrapyData;
    QString scrapyErrorData;
    //int numScannedFiles;

};

#endif // RUNSPIDERTHREAD_H
