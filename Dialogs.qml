import QtQuick
import QtQuick.Dialogs
import QtCore
Item {
    property alias fileOpen: _fileOpen
    property alias about: _about
    property alias tipDialoghigh:_tipDialoghigh
    property alias tipDialoglow:_tipDialoglow
    property alias tipDialoglowminutes:_tipDialoglowminutes
    property alias tipDialoglowhours:_tipDialoglowhour
    property alias fileOpen1: _fileOpen1
    property alias fileOpen2: _fileOpen2
    property alias errorabout:_errorabout
    FileDialog {
        id: _fileOpen
        title: "Select some song files"
        fileMode: FileDialog.OpenFiles
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        nameFilters: [ "video files (*.mp4 *.avi *.mkv)" ]
    }
    MessageDialog{
        id:_errorabout
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"can not find file"
    }
    FileDialog {
        id: _fileOpen2
        title: "Select some song files"
        fileMode: FileDialog.OpenFiles
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        nameFilters: [ "txt files (*.txt *docx *.srt)" ]
    }
    MessageDialog{
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"This is a free app."
        informativeText: qsTr("MultiMedia is a free software, and you can download its source code from www.open-src.com")
        detailedText: "CopyrightÂ©2024 zzs (open-src@qq.com)"
    }
    MessageDialog{
        id:_tipDialoglow
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"当前时间已经为000000,不能减小"
    }
    MessageDialog{
        id:_tipDialoglowhour
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"当前小时已经为00,不能减小"
    }
    MessageDialog{
        id:_tipDialoglowminutes
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"当前小时分钟已经为0000,不能减小"
    }
    MessageDialog{
        id:_tipDialoghigh
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"当前不能增加"
    }
    FileDialog {
        id: _fileOpen1
        title: "Select some picture files"
        fileMode: FileDialog.OpenFiles

        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        nameFilters: [ "Image files (*.png *.jpeg *.jpg)" ]
    }
}
