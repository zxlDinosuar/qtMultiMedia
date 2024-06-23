import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "multiMedia.js" as Controller

ApplicationWindow{
    id:mainWindow
    visible:true
    property int windowWidth: Screen.desktopAvailableWidth*0.85    //窗口宽度，跟随电脑屏幕变化
    property int windowHeight: Screen.desktopAvailableHeight*0.75  //窗口高度，跟随电脑屏幕变化

    width: windowWidth
    height: windowHeight

    menuBar:MenuBar{
        Menu{
            title: qsTr("文件")
            MenuItem{action: actions.open}//导入
            MenuItem{action: actions.derive}//导出
            MenuItem{action: actions.exit}
        }
        Menu{
            title: qsTr("关于")
            MenuItem{action: actions.about}
        }
    }

    header: ToolBar{
        id:appToolBar
        RowLayout{
            ToolButton{ action: actions.cut }//裁剪
            ToolButton{ action:actions.split}//拆分
            ToolButton{ action: actions.merge }//合并
            ToolButton{ action: actions.addPicture }//添加图片
            ToolButton{ action: actions.addText }//添加文字
            ToolButton{ action: actions.addSubtitles }//添加字幕
            ToolButton{ action: actions.clearVideolist }//清空视频列表
            ToolButton{ action: actions.clearMergelist }//清空合并列表
            ToolButton{ action: actions.addMergelistfromVideolist }//从视频列表添加到合并列表
        }
    }

    Actions{
        id:actions
        open.onTriggered: contents.dialogs.fileOpen.open()
        addMergelistfromVideolist.onTriggered: {
            // Controller.setmergefilesModel(contents.videoList.currentItem.filepath,contents.mergefilesModel,contents.mergeVideoList);
             contents.mediaDate.readPath(contents.videoList.currentItem.filepath)}
        cut.onTriggered: contents.mediaDate.videoEdit(contents.timeEdit1.times,contents.timeEdit2.times)
        split.onTriggered: contents.mediaDate.videoBreak(contents.timeEdit3.times,contents.sliderAnddurationtime.durationtime)
derive.onTriggered:Controller.showdialog(contents.saveDialogComponent)
        clearVideolist.onTriggered: contents.videofilesModel.clear()
        clearMergelist.onTriggered: {contents.mergefilesModel.clear()
        contents.mediaDate.deleteCombineList()
        }

        merge.onTriggered:contents.mediaDate.videoCombine()

        addPicture.onTriggered:contents.dialogs.fileOpen1.open()
        exit.onTriggered:Qt.quit()
        about.onTriggered: contents.dialogs.about.open()
        addSubtitles.onTriggered: contents.dialogs.fileOpen2.open()
        addText.onTriggered:Controller.showdialog(contents.textInputDialogComponent)
    }

    Contents{
        id:contents
        anchors.fill: parent
    }

 }


















