#include "mediadate.h"
#include <QFile>
#include <QFileInfo>
#include <QProcess>
#include <QString>

MediaDate::MediaDate(QObject *parent)
    : QObject{parent}
{
    //每次运行前都首先清空用于合并视频的txt文件
    QFile file(combPath); //用于合并视频的文件
    file.open(QFile::WriteOnly | QFile::Truncate);
    file.close();
}

QString MediaDate::changeValue(QString inputpath)
{
    QString path;
    // 检查字符串是否以 "file:///" 开头
    if (inputpath.startsWith("file:///")) {
        // 使用 mid 函数提取 "file:///" 之后的内容
        path = inputpath.mid(7);

        // 因为Qt中URL编码的字符（如空格被编码为%20）需要解码，
        // 所以我们使用 QUrl::fromPercentEncoding 来解码这些字符
        path = QUrl::fromPercentEncoding(path.toUtf8());
    }
    qDebug() << path;
    return path;
}

//点击视频列表内的视频能在预览窗口进行播放，并且复制一份用于剪切，播放并替换窗口对应视频
//不能用于new.mp4
void MediaDate::list_item_clicked(QString itemPath)
{
    QString strFileOrg = changeValue(itemPath);
    QFile file(inputPath);
    //如果文件存在就先移除再复制，否则直接复制
    if (file.exists()) {
        file.remove();                      //移除已经存在的文件
        QFile::copy(strFileOrg, inputPath); //文件复制
    } else {
        QFile::copy(strFileOrg, inputPath); //文件复制
    }
}

//导出视频
void MediaDate::saveFile(QString savePath)
{
    QFile::copy(inputPath, savePath); //文件复制
}

//剪切视频功能，需要首先设置剪切时间范围
void MediaDate::videoEdit(QString startTime, QString lenTime)
{
    QFile sourceFile(inputPath);
    if (!sourceFile.exists()) {
        // qDebug() << "找不到源文件";
        emit cannotFindFile();
        return;
    }
    int temp = 1;
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/clip_" + QString::number(temp)
                         + ".mp4";
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/clip_" + QString::number(temp)
                     + ".mp4";
    }
    QString sTime = startTime;
    QString lTime = lenTime;
    QStringList arguments;
    arguments << "-i" << inputPath << "-r"
              << "25"
              << "-ss";
    arguments << sTime << "-to" << lTime << outputPath;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);

    clipProcess->start(program, arguments);
    emit addToVideoList(outputPath);
}

//拆分视频为两个片段
void MediaDate::videoBreak(QString breakTime, QString durationTime)
{
    QFile sourceFile(inputPath);
    if (!sourceFile.exists()) {
        // qDebug() << "找不到源文件";
        emit cannotFindFile();
        return;
    }
    int temp = 1;
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp)
                         + "_1.mp4";
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp)
                     + "_1.mp4";
    }
    QString bTime = breakTime;
    QString str = durationTime;

    QStringList arguments;
    arguments << "-i" << inputPath << "-r"
              << "25"
              << "-ss";
    arguments << "0:00:00"
              << "-to" << bTime << outputPath;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    emit addToVideoList(outputPath);

    arguments.clear();
    outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp) + "_2.mp4";
    arguments << "-i" << inputPath << "-r"
              << "25"
              << "-ss";
    arguments << bTime << "-to" << str << outputPath;
    qDebug() << arguments;

    //每个 QProcess 对象都可以独立地运行一个外部程序（在这个例子中是 ffmpeg）并处理其输出。//这样做可以让两个视频处理任务并行进行，而不是顺序执行，从而可能提高效率。
    //使用两个不同的 QProcess 对象还可以简化错误处理和流程控制。
    //每个进程可以独立地监控和响应其对应的 ffmpeg 进程的状态，例如完成、错误或输出消息。
    QProcess *m_Process = new QProcess(this); //定义一个新的QProcess
    m_Process->start(program, arguments);
    //用信号实现
    emit addToVideoList(outputPath);
}