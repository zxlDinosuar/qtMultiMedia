#pragma once

#include <QMainWindow>
#include <QTime>
#include <QtQml/qqmlregistration.h>

class QMediaPlayer;
class QAudioOutput;
class QVideoWidget;
class QTimer;

class Mediapaly : public QMainWindow
{
    Q_OBJECT

    QML_ELEMENT
    //C++的信号，public槽函数，Q_INVOKABLE 修饰的类成员函数就可以在qml中调用
public:
    Q_INVOKABLE void list_item_clicked(QString itemPath);
    Q_INVOKABLE void slider_progress_moved(int slider_progressValue);
    Q_INVOKABLE void slider_progress_released();

public:
    explicit Mediapaly(QWidget *parent = nullptr);
    void videoShow(QString path);
    void onTimerOut();
    void getduration(qint64 playtime);

signals:
    void setslider_progressEnabled();
    void setslider_progressRange(int from, int to);
    void setslider_progressValue(int Value);
    void setlabel_timeText(QString);
    void cannotFindFile();

private:
    QString program = "/usr/bin/ffmpeg";
    QString inputPath = "/root/aaa/Qt6Video/resource/new.mp4";
    QString combPath = "/root/aaa/Qt6Video/resource/combineList.txt";
    QMediaPlayer *m_player;
    QAudioOutput *m_audiooutput;
    QVideoWidget *m_videoWidget;
    int maxValue;    //滑动条最大范围
    QTimer *m_timer; //计时器
    QTime startTime; //裁剪开始时间
    QTime lenTime;   //裁剪结束时间
    QTime breakTime; //裁剪结束时间
};
