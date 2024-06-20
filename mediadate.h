#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QtQml/qqmlregistration.h>

class MediaDate : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    Q_INVOKABLE void list_item_clicked(QString itemPath);
    Q_INVOKABLE void saveFile(QString savePath);
    Q_INVOKABLE void videoEdit(QString startTime, QString lenTime);
    Q_INVOKABLE void videoBreak(QString breakTime, QString durationTime);

public:
    explicit MediaDate(QObject *parent = nullptr);
    // QString changeValue(QString &inputpath);
    QString changeValue(QString inputpath);

signals:
    void cannotFindFile();
    void addToVideoList(QString outputPath);

private:
    QString program = "/usr/bin/ffmpeg";
    QString inputPath = "/root/bbb/resource/currentItem.mp4";
    QString combPath = "/root/bbb/resource/combineList.txt";
};
