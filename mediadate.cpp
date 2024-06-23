#include "mediadate.h"
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QProcess>
#include <QString>

MediaDate::MediaDate(QObject *parent)
    : QObject{parent}
{
    QDir directory = QFileInfo(inputPath).dir();

    if (!directory.exists()) {
        directory.mkpath(directory.path()); // 创建所有必需的父目录
    }

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
    return path;
}

//点击视频列表内的视频能在预览窗口进行播放，并且复制一份用于剪切，播放并替换窗口对应视频
//不能用于new.mp4
void MediaDate::list_item_clicked(QString itemPath)
{
    QString strFileOrg = changeValue(itemPath);

    QFile sourceFile(inputPath);
    QFileInfo fileInfo(strFileOrg);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    inputPath = QFileInfo(sourceFile).absolutePath() + "/currentItem." + fileExtension;

    QFile file(inputPath);
    //如果文件存在就先移除再复制，否则直接复制
    if (file.exists()) {
        file.remove();                      //移除已经存在的文件
        QFile::copy(strFileOrg, inputPath); //文件复制
        // changeTomp4(strFileOrg, inputPath);
    } else {
        QFile::copy(strFileOrg, inputPath); //文件复制
        // changeTomp4(strFileOrg, inputPath);
    }
}

//导出视频
void MediaDate::saveFile(QString savePath)
{
    QFile::copy(inputPath, savePath); //文件复制
}

//剪切视频功能，需要首先设置剪切时间范围
void MediaDate::videoEdit(QString startTime, QString endTime)
{
    QFile sourceFile(inputPath);
    if (!sourceFile.exists()) {
        // qDebug() << "找不到源文件";
        emit cannotFindFile();
        return;
    }
    int temp = 1;
    QFileInfo fileInfo(inputPath);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/clip_" + QString::number(temp)
                         + "." + fileExtension;
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/clip_" + QString::number(temp) + "."
                     + fileExtension;
    }
    QString sTime = QUrl::fromPercentEncoding(startTime.toUtf8());
    QString lTime = QUrl::fromPercentEncoding(endTime.toUtf8());
    QStringList arguments;
    arguments << "-i" << inputPath << "-r"
              << "25"
              << "-ss";
    arguments << sTime << "-to" << lTime << outputPath;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);

    clipProcess->start(program, arguments);
    emit addToVideoList(QUrl::fromLocalFile(outputPath));
    // QUrl url = QUrl::fromLocalFile(outputPath);
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
    QFileInfo fileInfo(inputPath);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp)
                         + "_1." + fileExtension;
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp) + "_1."
                     + fileExtension;
    }
    QString bTime = QUrl::fromPercentEncoding(breakTime.toUtf8());
    // QString bTime = breakTime;
    QString str = QUrl::fromPercentEncoding(durationTime.toUtf8());
    // QString str = durationTime;

    QStringList arguments;
    arguments << "-i" << inputPath << "-r"
              << "25"
              << "-ss";
    arguments << "0:00:00"
              << "-to" << bTime << outputPath;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    emit addToVideoList(QUrl::fromLocalFile(outputPath));

    arguments.clear();
    outputPath = QFileInfo(sourceFile).absolutePath() + "/break" + QString::number(temp) + "_2."
                 + fileExtension;
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
    emit addToVideoList(QUrl::fromLocalFile(outputPath));
}
//读取剪切出来的视频路径放入txt文件中，用于进行合并
//需要点击一下合并列表中的视频，才能进行合并
void MediaDate::readPath(QUrl filePath)
{
    QString path = changeValue(filePath.toString());
    //写入文件
    qDebug() << path;

    QFile sourceFile(inputPath);
    QFileInfo fileInfo(path);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    QString correctPath = inputPath;

    // 判断文件扩展名是否为.mp4，如果不是，则修改为.mp4
    if (fileExtension != "mp4") {
        QString baseName = fileInfo.completeBaseName(); // 获取不带扩展名的文件名
        correctPath = QFileInfo(sourceFile).absolutePath() + "/" + baseName
                      + ".mp4"; // 替换为.mp4扩展名
        changeTomp4(inputPath, correctPath);
        sleep(1);
    }

    QFile file;
    file.setFileName(combPath);
    qDebug() << "File opened for writing";
    if (file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Append)) {
        QTextStream stream(&file);
        qDebug("test");
        stream << "file '" << correctPath << "'"
               << "\n";
        qDebug("test");
        file.close();
        qDebug() << "File closed after writing";
        emit addTomergeVideoListt(QUrl::fromLocalFile(correctPath));
    }
}
//将读取到的txt列表中的视频进行合并
void MediaDate::videoCombine()
{
    //ffmpeg -f concat -safe 0 -i 2.txt -c copy -y o1.mp4
    QFile sourceFile(inputPath);

    if (!sourceFile.exists()) {
        emit cannotFindFile();
        return;
    }
    int temp = 1;
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/Combine_" + QString::number(temp)
                         + ".mp4";
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/Combine_" + QString::number(temp)
                     + ".mp4";
    }
    QStringList arguments;
    arguments << "-f"
              << "concat"
              << "-safe"
              << "0"
              << "-i";
    arguments << combPath << "-c"
              << "copy"
              << "-y" << outputPath;
    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    //把合并后的视频放入视频列表
    emit addToVideoList(QUrl::fromLocalFile(outputPath));
}

void MediaDate::deleteCombineList()
{
    QFile file(combPath);
    file.open(QFile::WriteOnly | QFile::Truncate);
    file.close();
}

//素材库添加文字
void MediaDate::addText(QUrl textName)
{
    qDebug() << "textName:" << textName;
    QString text = textName.toString();
    qDebug() << text;
    QFile sourceFile(inputPath);
    if (!sourceFile.exists()) {
        emit cannotFindFile();
        return;
    }
    QString outputPath;
    QFileInfo fileInfo(inputPath);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    int temp = 1;
    outputPath = QFileInfo(sourceFile).absolutePath() + "/addText" + QString::number(temp) + "."
                 + fileExtension;
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/addText" + QString::number(temp) + "."
                     + fileExtension;
    }
        addPath = outputPath;
    outputPath = addPath;

    QStringList arguments;
    //设置起止时间
    QString str = "drawtext=text='" + text + "':x=20:y=20:fontsize=100:fontcolor=yellow:shadowy=2";
    arguments << "-i" << inputPath << "-vf" << str;
    arguments << outputPath;
    qDebug() << str;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    emit addToVideoList(QUrl::fromLocalFile(outputPath));
}

//添加字幕，并且能嵌入视频中
void MediaDate::onActionAddTitle(QUrl titleName)
{
    qDebug() << "textName:" << titleName;
    QString title = changeValue(titleName.toString());
    qDebug() << title;
    QFile sourceFile(inputPath);
    if (!sourceFile.exists()) {
        emit cannotFindFile();
        return;
    }

    QFileInfo fileInfo(inputPath);
    QString fileExtension = fileInfo.suffix(); // 获取文件扩展名
    int temp = 1;
    QString outputPath = QFileInfo(sourceFile).absolutePath() + "/addTitle" + QString::number(temp)
                         + "." + fileExtension;
    while (QFile::exists(outputPath)) {
        temp++;
        outputPath = QFileInfo(sourceFile).absolutePath() + "/addTitle" + QString::number(temp)
                     + "." + fileExtension;
    }

    QString str = "subtitles=\\'" + title + "'";

    QStringList arguments;
    arguments << "-i" << inputPath << "-vf" << str;
    arguments << "-y" << outputPath;
    qDebug() << arguments;

    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    emit addToVideoList(QUrl::fromLocalFile(outputPath));
}

//将输入文件转换为mp4文件
void MediaDate::changeTomp4(QString strFileOrg, QString outputPath)
{
    // 实现将strFileOrg对应的文件转换为.mp4文件
    QStringList arguments;
    arguments << "-i" << strFileOrg << "-c:v"
              << "libx264"
              << "-preset"
              << "medium"
              << "-crf"
              << "23"
              << "-c:a"
              << "aac"
              << "-b:a"
              << "128k" << outputPath;
    QProcess *clipProcess = new QProcess(this);
    clipProcess->start(program, arguments);
    qDebug() << outputPath;
}
