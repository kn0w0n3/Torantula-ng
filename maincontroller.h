#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H
#include <QObject>

#include <QDebug>
#include <QStringList>
#include "logthread.h"
#include "runspiderthread.h"

class MainController: public QObject{
    Q_OBJECT

public:
    MainController(QObject *parent = nullptr);

signals:
    void scrapyDataToQml(QString scrapyData_1);
    void scrapyLogDataToQml(QString scanLogData_1);
    void scanLogStatusStartedToQml();
    void scanLogStatusStoppedToQml();

    void scrapyCliDataToQml(QString scrapyCliData_1);
    void spiderStatusStartedToQml();
    void spiderStatusStoppedToQml();

public slots:
    void runSpider(void);
    void startScanLogThread(void);

    void startSpiderThread(void);
    void spiderThreadDataRelay(QString);
    void spiderStatusRelay(QString);

    void scanLogStatus(QString);
    void scanLogStreamDataRelay(QString);

private:
    QString scrapyData;

    QString scrapyErrorData;
    LogThread *logThread;
    QString scanLogData;
    RunSpiderThread *runSpiderThread;
};

#endif // MAINCONTROLLER_H
