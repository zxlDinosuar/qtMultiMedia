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
        text:"This is a simple music player."
        informativeText: qsTr("MultiMedia is a free software, and you can download its source code from www.open-src.com")
        detailedText: "CopyrightÂ©2024 Wei Gong (open-src@qq.com)"
    }

}
