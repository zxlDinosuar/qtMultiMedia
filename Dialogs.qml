import QtQuick
import QtQuick.Dialogs
import QtCore
Item {
    property alias fileOpen: _fileOpen
    property alias about: _about

    FileDialog {
            id: _fileOpen
            title: "Select some song files"
            fileMode: FileDialog.OpenFiles

            currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
            nameFilters: [ "video files (*.mp4)" ]
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
        text:"当前时间已经为00000,不能减小"
    }
    MessageDialog{
        id:_tipDialoghigh
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"当前时间已经为视频的最长时间，不能增加"
    }
}
