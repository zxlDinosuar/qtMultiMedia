import QtQuick
import QtQuick.Dialogs
import QtCore
Item {
    property  alias open:_open
    FileDialog {
        id: _open
        title: "视频导入"
        currentFolder: StandardPaths.standardLocations
                       (StandardPaths.DocumentsLocation)[0]
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Audio files (*.mp4 *)" ]
    }
}
