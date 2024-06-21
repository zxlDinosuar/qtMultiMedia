import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

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
        }
    }

    Actions{
        id:actions
        open.onTriggered: contents.dialogs.fileOpen.open()
        cut.onTriggered:{console.log("zzxxzxz")
            console.log(contents.cutStart.starttime)
            console.log(contents.cutEnd.endTime)
        }
        addPicture.onTriggered:contents.dialogs.fileOpen1.open()
        exit.onTriggered:Qt.quit()
    }

    Contents{
        id:contents
        anchors.fill: parent
    }

 }


















