import QtQuick.Controls
import QtQuick

Item {
    property alias open:_open
    property alias cut:_cut
    property alias derive:_derive
    property alias exit:_exit
    property alias split: _split
    property alias merge:_merge
    property alias addPicture:_addPicture
    property alias addText:_addText
    property alias addSubtitles:_addSubtitles
    property alias clearVideolist:_clearVideolist
    property alias clearMergelist:_clearMergelist
    property alias addMergelistfromVideolist:_addMergelistfromVideolist
    property alias about:_about


    Action {
        id: _open
        text: qsTr("导入")
        // icon.name: "document-open"
        // shortcut: "StandardKey.Open"
    }
    Action {
        id: _derive
        text: qsTr("导出")
        // icon.name: "document-open"
        // shortcut: "StandardKey.Open"
    }

    Action {
        id: _exit
        text: qsTr("退出")
        //icon.name: "application-exit"
    }
    Action {
        id: _cut
        text: qsTr("裁剪")
        //icon.name: "application-exit"
    }
    Action {
        id: _split
        text: qsTr("拆分")
        //icon.name: "application-exit"
    }
    Action {
        id: _merge
        text: qsTr("合并")
        //icon.name: "application-exit"
    }
    Action {
        id: _addPicture
        text: qsTr("添加图片")
        //icon.name: "application-exit"
    }
    Action {
        id: _addText
        text: qsTr("添加文字")
        //icon.name: "application-exit"
    }
    Action {
        id: _addSubtitles
        text: qsTr("添加字幕")
        //icon.name: "application-exit"
    }
    Action {
        id: _clearVideolist
        text: qsTr("清空视频列表")
        //icon.name: "application-exit"
    }
    Action {
        id: _clearMergelist
        text: qsTr("清空合并列表")
        //icon.name: "application-exit"
    }
    Action{
       id:_addMergelistfromVideolist
       text:qsTr("从视频列表添加到合并列表")
    }
    Action{
       id:_about
       text:qsTr("关于")
    }
}
