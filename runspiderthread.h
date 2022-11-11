#ifndef RUNSPIDERTHREAD_H
#define RUNSPIDERTHREAD_H
#include <QThread>
#include <QObject>
#include <QProcess>
#include <QTextStream>
#include <QDebug>

class RunSpiderThread: public QThread{
    Q_OBJECT

public:
    RunSpiderThread(QThread *parent = 0);
    void run();

signals:
    void spiderRunStatus(QString);
    void scrapyConsoleData(QString);

public slots:

private:
    QString scrapyData;
    QString scrapyErrorData;
};

#endif // RUNSPIDERTHREAD_H
