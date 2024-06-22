#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QUrl>
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
    Q_INVOKABLE void readPath(QUrl filePath);
    Q_INVOKABLE void videoCombine();
    Q_INVOKABLE void deleteCombineList();

public:
    explicit MediaDate(QObject *parent = nullptr);
    // QString changeValue(QString &inputpath);
    QString changeValue(QString inputpath);

signals:
    void cannotFindFile();
    void addToVideoList(QUrl outputPath);

private:
    QString program = "/usr/bin/ffmpeg";
    QString inputPath = "/root/bbb/resource/currentItem.mp4";
    QString combPath = "/root/bbb/resource/combineList.txt";
};
