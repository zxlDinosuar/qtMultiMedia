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
    Q_INVOKABLE void addText(QUrl textName);
    Q_INVOKABLE void onActionAddTitle(QUrl titleName);
    Q_INVOKABLE void addToLeft(QUrl filePath);
    Q_INVOKABLE void addToRight(QUrl filePath);
    Q_INVOKABLE void move(QUrl filePath);

public:
    explicit MediaDate(QObject *parent = nullptr);
    // QString changeValue(QString &inputpath);
    QString changeValue(QString inputpath);
    void changeTomp4(QString strFileOrg, QString outputPath);

signals:
    void cannotFindFile();
    void addToVideoList(QUrl outputPath);
    void addTomergeVideoListt(QUrl outputPath);
    void addClickedChanged();

private:
    QString program = "/usr/bin/ffmpeg";
    QString inputPath = "/root/bbb/resource/currentItem.mp4";
    QString inputImagePath = "/root/bbb/images/";
    QString combPath = "/root/bbb/resource/combineList.txt";
    bool m_addClicked;
    QString addPath;
};
