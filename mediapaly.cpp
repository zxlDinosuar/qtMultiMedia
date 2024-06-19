#include "mediapaly.h"
#include <QAudioOutput> //音频
#include <QDateTime>
#include <QFile>
#include <QFileDialog>
#include <QFileInfo>
#include <QInputDialog>
#include <QMediaPlayer> //播放器
#include <QProcess>
#include <QString>
#include <QTime>
#include <QTimer>
#include <QVideoWidget> //播放窗口

Mediapaly::Mediapaly(QWidget *parent)
    : QMainWindow{parent}
{
    m_player = new QMediaPlayer();          //视频播放对象
    m_audiooutput = new QAudioOutput();     //音频播放
    m_videoWidget = new QVideoWidget(this); //显示视频的自定义窗口
    m_timer = new QTimer(this);             //计时器
    maxValue = 100;                         //设置进度条的最大值

    //每次运行前都首先清空用于合并视频的txt文件
    QFile file(combPath); //用于合并视频的文件
    file.open(QFile::WriteOnly | QFile::Truncate);
    file.close();
}

//添加定时器的槽函数onTimerOut()，根据一定的间隔（100ms）刷新Slider的值
void Mediapaly::onTimerOut()
{
    if (m_player->duration() > 0) {
        emit setslider_progressValue(int(m_player->position() * maxValue / m_player->duration()));
        //修改滑动条的位置
    } else
        return;
}
//拖动进度条
void Mediapaly::slider_progress_moved(int slider_progressValue)
{
    m_timer->stop(); //暂时停止计时器，在用户拖动过程中不修改slider的值
    m_player->setPosition(slider_progressValue * m_player->duration() / maxValue); //播放窗口设置位置
}
//用户释放滑块后，重启定时器
void Mediapaly::slider_progress_released()
{
    m_timer->start();
}
//获取视频时间并显示
void Mediapaly::getduration(qint64 playtime)
{
    playtime = m_player->duration();
    int h, m, s;
    playtime /= 1000; //获得的时间是以毫秒为单位的
    h = playtime / 3600;
    m = (playtime - h * 3600) / 60;
    s = playtime - h * 3600 - m * 60;
    emit setlabel_timeText(
        QString("%1:%2:%3").arg(h).arg(m).arg(s)); //把int型转化为string类型后再设置为label的text
}
//视频播放功能
void Mediapaly::videoShow(QString path)
{
    //如果没有该文件就直接返回
    QFile sourceFile(path);
    if (!sourceFile.exists()) {
        // QMessageBox::information(this, QString::fromUtf8("提示"), QString::fromUtf8("找不到源文件"));
        // qDebug() << "找不到源文件";
        emit cannotFindFile();
        return;
    }
    m_player->setSource(QUrl::fromLocalFile(path)); //视频来源
    m_player->setVideoOutput(m_videoWidget);        //视频输出
    m_player->setAudioOutput(m_audiooutput);        //设置声音
    int voice = 50;
    m_audiooutput->setVolume(voice); //初始音量为50
    if (m_player->error() == 1) {
        // qDebug() << "找不到源文件";
        emit cannotFindFile();
        return;
    }
    m_player->play(); //视频播放

    emit setslider_progressEnabled(); //需要Qml端修改slider_progress为可滑动

    emit setslider_progressRange(0, maxValue); //设置滑动条的范围

    m_timer->setInterval(100); //如果想看起来流畅些，可以把时间间隔调小，如100ms
    m_timer->start();
    //将timer连接至onTimerOut槽函数
    connect(m_timer, SIGNAL(timeout()), this, SLOT(onTimerOut()));
    //获取并显示视频时间
    connect(m_player, SIGNAL(durationChanged(qint64)), this, SLOT(getduration(qint64)));
}
//点击视频列表内的视频能在预览窗口进行播放，并且复制一份用于剪切，播放并替换窗口对应视频
//不能用于new.mp4
void Mediapaly::list_item_clicked(QString itemPath)
{
    videoShow(itemPath); //播放选中的视频
    //复制视频
    QString strFileOrg = itemPath;
    // QString strFileCopyPath = "/root/aaa/Qt6Video/resource/"; //要拷贝到的目标文件夹
    // QString strFIleName = "new.mp4";                          //新的名字
    QFile file(inputPath);
    //如果文件存在就先移除再复制，否则直接复制
    if (file.exists()) {
        file.remove(); //移除已经存在的文件
        // QFile::copy(strFileOrg, strFileCopyPath + strFIleName); //文件复制
        QFile::copy(strFileOrg, inputPath); //文件复制
    } else {
        // QFile::copy(strFileOrg, strFileCopyPath + strFIleName); //文件复制
        QFile::copy(strFileOrg, inputPath); //文件复制
    }
}
//双击视频列表中的视频可以修改名称（左右键均可）
//UI实现
