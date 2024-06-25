import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "multiMedia.js" as Controller
import QtMultimedia
import multiMedia

Item {
    property alias dialogs: _allDialogs
    property alias player: _player
    property alias videoList: _videoList
    property alias videofilesModel:filesModel
    property alias mergeVideoList: _mergeVideolist
    property alias mergefilesModel:_mergefilesModel
    property alias mediaDate:_mediaDate
    property alias audioOutput: _audioOutput
    property alias progressSlider:_progressSlider
    // property alias cutStart: _cutStart
    // property alias cutEnd: _cutEnd
    // property alias split:_split
    property alias sliderAnddurationtime: _sliderAnddurationtime
    property alias timeEdit1: _timeEdit1
    property alias timeEdit2: _timeEdit2
    property alias timeEdit3: _timeEdit3
    property alias saveDialogComponent:_saveDialogComponent
    property alias textInputDialogComponent:_textInputDialogComponent
    Dialogs {
        id:_allDialogs
        fileOpen.onAccepted: Controller.setFilesModel(fileOpen.selectedFiles,filesModel,videoList)
        fileOpen1.onAccepted: Controller.setFileModel(fileOpen1.selectedFiles,video_fileModel,multiPics)
        fileOpen2.onAccepted: {Controller.setModel(fileOpen2.selectedFile)
            mediaDate.onActionAddTitle(fileOpen2.selectedFile)
        }
    }

    Connections {
        target: mediaDate
        function onAddToVideoList(outputPath) {
            Controller.addtoVideoList(Qt.url(outputPath), filesModel)
        }
    }
    Connections {
        target: mediaDate
        function onAddTomergeVideoListt(outputPath) {
            Controller.addtomergeVideoList(Qt.url(outputPath), mergefilesModel)
        }
    }
    Connections {
        target:mediaDate
        function onCannotFindFile() {
            Controller.errorab(dialogs.errorabout)
        }
    }
    MediaDate {
        id:_mediaDate
    }
    Rectangle{//left
        width: parent.width*0.7
        height:parent.height
        TapHandler{
            onTapped: {
                Controller.exit_singleView(add);
            }
        }
        // property int  flags
        Rectangle{//leftTop
            width:parent.width
            height:parent.height*0.5
            Rectangle{
                width:parent.width*0.5
                height:parent.height
                color:Qt.rgba(0,0,0,0.6)
                border.color: "black" // 边框的颜色
                border.width: 2 // 边框的宽度
                MediaPlayer {
                    id:_player
                    audioOutput: AudioOutput {
                        id:_audioOutput
                    }
                    videoOutput: myvideoOutput
                }
                VideoOutput {
                    id:myvideoOutput
                    anchors.fill: parent
                    focus: true
                    Keys.onSpacePressed: player.playbackState === MediaPlayer.PlayingState ? player.pause():player.play()
                    Keys.onLeftPressed: player.position = player.position - 5000
                    Keys.onRightPressed: player.position = player.position + 5000
                }
            }
            Rectangle{//timeEdit
                width:parent.width*0.5
                height:parent.height
                x:parent.width*0.5
                Rectangle{
                    id:_leftTop_right_top
                    // property int flag
                    width:parent.width
                    height:parent.height*0.5
                    Rectangle{
                        id:_cutStart
                        property int  flags
                        width:parent.width
                        height:parent.height/4
                        Rectangle{
                            width:parent.width*0.3
                            height: parent.height
                            Label
                            {
                                width:parent.width
                                height: parent.height
                                text:"剪切开始："
                                // text:time1.times
                                color:"black"
                                leftPadding: parent.width/2
                                //topPadding: parent.width/7
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        //实现QTimeEdit相似的功能
                        Rectangle{
                            width:parent.width*0.7
                            height:parent.height
                            x:parent.width*0.55
                            TimeEdit{
                                id:_timeEdit1
                                width:parent.width
                                height:parent.height
                            }
                        }
                    }
                    Rectangle{
                        id:_cutEnd
                        property int  flags
                        focus: true
                        y:parent.height/4
                        width:parent.width
                        height:parent.height/4
                        Rectangle{
                            width:parent.width*0.3
                            height: parent.height
                            Label
                            {
                                width:parent.width
                                height: parent.height
                                text:"剪切结束："
                                // text:time2.times
                                color:"black"
                                leftPadding: parent.width/2
                                //topPadding: parent.width/7
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        //实现QTimeEdit相似的功能
                        Rectangle{
                            width:parent.width*0.7
                            height:parent.height
                            x:parent.width*0.55
                            TimeEdit{
                                id:_timeEdit2
                                width:parent.width
                                height:parent.height
                            }
                        }

                    }

                }
                Rectangle{
                    id:_leftTop_rightBottom
                    width:parent.width
                    height:parent.height/2
                    y:parent.height/2
                    Rectangle{
                        id:_split
                        property int  flags
                        focus: true
                        width:parent.width
                        height:parent.height/4
                        Rectangle{
                            width:parent.width*0.3
                            height: parent.height
                            Label
                            {
                                width:parent.width
                                height: parent.height
                                text:"拆分节点："
                                color:"black"
                                leftPadding: parent.width/2
                                verticalAlignment: Text.AlignVCenter
                                //topPadding: parent.width/7

                            }
                        }

                        //实现QTimeEdit相似的功能
                        Rectangle{
                            width:parent.width*0.7
                            height:parent.height
                            x:parent.width*0.55
                            TimeEdit{
                                id:_timeEdit3
                                width:parent.width
                                height:parent.height
                            }
                        }


                    }

                }
            }
        }
        Rectangle{//leftCenter
            id:_sliderAnddurationtime
            property string durationtime//用于存储总时间
            durationtime: Controller.formatTime(player.duration)
            width:parent.width
            height:parent.height*0.1
            y:parent.height*0.5
            color:Qt.rgba(0,0,0,0.6)
            Slider {
                id:_progressSlider
                width:parent.width*0.5
                height: parent.height
                enabled: player.seekable
                value: player.duration > 0 ? player.position / player.duration : 0
                onMoved:{
                    player.position = player.duration * progressSlider.position
                    myvideoOutput.focus = true
                }
            }
            Label {
                width:parent.width*0.1
                height: parent.height
                x:parent.width*0.51
                text: "当前时间："
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                width:parent.width*0.1
                height: parent.height
                x:parent.width*0.6
                text: Controller.formatTime(player.position)
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                width:parent.width*0.1
                height: parent.height
                x:parent.width*0.71
                text: "总时长："
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                width:parent.width*0.1
                height: parent.height
                x:parent.width*0.8
                text: Controller.formatTime(player.duration)
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{//leftBottom
            width:parent.width
            height:parent.height*0.4
            y:parent.height*0.6

            Rectangle{
                width:parent.width
                height:parent.height*0.1
                color:Qt.rgba(0,0,0,0.6)
                Label {
                    height:parent.height
                    text:"素材库"
                    verticalAlignment: Text.AlignVCenter
                }
                Button{
                    visible: true
                    id:butt
                    x:parent.width*0.80
                    text:"添加特效"
                    height:parent.height
                    onClicked: teixiao.visible=true
                }
                // Button{
                //     visible: false
                //     id:but
                //     text:"^"
                //     x:butt.x+85
                //     TapHandler{
                //         id:more
                //         onTapped:
                //         {
                //             Controller.showdialog(teixiao)
                //         }
                //     }
                // }
                ColumnLayout {

                    id: teixiao
                    visible: false // 默认隐藏，您可以根据需要设置条件来显示
                    x: butt.x +81
                    y: butt.y-88

                    focus: true
                    //  Text { text: '<b>Name:</b> ' + model.name } // 使用 model.name
                    Button{text: '淡入';onClicked:{teixiao.visible=false
                         Controller.showdialog(_fadein)}}
                    Button{text: '淡出';onClicked:{teixiao.visible=false
                        Controller.showdialog(_fadeout)}}
                    Button{text: '旋转';onClicked:{teixiao.visible=false
                            mediaDate.rotate(multiPics.currentItem.source)}}
                    Button{text: '移动';onClicked:{teixiao.visible=false
                            _mediaDate.move(multiPics.currentItem.source) }}
                }
            }
            Rectangle{
                width:parent.width
                height:parent.height*0.9
                color:Qt.rgba(0,0,0,0.6)
                y:parent.height*0.1
                border.color: "black" // 边框的颜色
                border.width: 2 // 边框的宽度

                GridView{
                    id:multiPics
                    anchors.fill: parent
                    // fillMode 设置为 Image.PreserveAspectFit 时，
                    // 图片会保持其原始的宽高比，同时尽可能大地填充可用空间，
                    // 而不会超出矩形的边界。
                    // Image.Stretch：拉伸图像以填充可用空间，不考虑宽高比，可能导致图像失真。
                    // Image.PreserveAspectCrop：保持图像的宽高比，但是可能会裁剪图像的某些部分以确保图像完全填充可用空间。
                    // Image.Tile：平铺图像以填充可用空间。
                    property int fillMode: Image.PreserveAspectFit
                    // 数据模型负责存储和组织数据，而视图则负责展示这些数据
                    ListModel{
                        id:video_fileModel
                    }
                    // delegate 是一个QML组件，它负责将数据模型中的数据以某种形式展示出来。
                    delegate: imageDelegate

                }
                Component{
                    id:imageDelegate
                    Image {
                        // 加载每一张图片6+
                        id:image
                        // 每个网格的宽度和高度减10作为图片的显示高度和宽度
                        width: multiPics.cellWidth-10
                        height: multiPics.cellHeight-10
                        // 指图片如何填充可用空间
                        fillMode:multiPics.fillMode
                        // asynchronous: true 属性通常与图像加载相关，特别是在使用 Image 类型时。当 asynchronous 属性设置为 true 时，
                        // 图像的加载将在一个单独的线程中进行，
                        // 这意味着图像加载不会阻塞主线程，
                        asynchronous: true
                        // 所有的路径对应的都是filePath因此可以使用直接显示所有的图片
                        source: filePath
                        TapHandler{
                            id:tapHandler
                            onTapped: {
                                multiPics.currentIndex = index
                                console.log("currentIndex in multiPics: ", multiPics.currentIndex)
                                Controller.singleView(singlePic)
                            }
                        }
                        TapHandler{
                            id:rightclick
                            acceptedButtons: Qt.RightButton
                            onTapped:
                            {
                                multiPics.currentIndex = index
                                Controller.addmoreView(add,multiPics)
                            }
                        }
                    }

                }
                ColumnLayout
                {
                    id:add
                    visible:false

                    Button {
                        text: "删除"
                        onClicked: add.visible = false
                        TapHandler{
                            id:halo
                            onTapped: {
                                Controller.del(multiPics.currentIndex,video_fileModel);
                            }
                        }

                    }
                    Button {
                        text: "添加到视频左上角"
                        onClicked: {add.visible = false
                            _mediaDate.addToLeft(multiPics.currentItem.source)
                        }
                    }
                    Button {
                        text: "添加到视频右上角"
                        onClicked: {add.visible = false
                            _mediaDate.addToRight(multiPics.currentItem.source)}
                    }


                }
                Image {
                    id: singlePic
                    anchors.fill: parent
                    source: multiPics.currentItem.source
                    z:-1
                    visible: false

                    TapHandler{
                        id:tapHandler
                        onTapped: {
                            console.log("exit")
                            Controller.exit_singleView(singlePic)
                        }
                    }
                }
            }
        }
    }
    Rectangle{//right
        x:parent.width*0.7
        width: parent.width*0.3
        height:parent.height
        // opacity: 0.0
        color:Qt.rgba(0,0,0,0.6)
        Rectangle{
            width:parent.width
            height:parent.height*0.5
            Label {
                width:parent.width
                height:parent.height*0.1
                text:"视频列表"
                color: "black"
            }
            Rectangle {
                width:parent.width
                height:parent.height*0.9
                y:parent.height*0.1
                ListView{
                    id:_videoList
                    anchors.fill: parent

                    model: ListModel{
                        id: filesModel
                    }
                    delegate: VideoDelegate{id: videoItem}
                }

                component VideoDelegate: Rectangle {
                    id:videoRoot
                    property url filepath:filePath
                    width: parent.width
                    height: 30
                    Text {
                        id:text
                        verticalAlignment:Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        color: videoRoot.ListView.isCurrentItem?"red":"black"
                        width: videoItem.width
                        font.pixelSize: 13
                        text: filePath
                    }

                    TapHandler {
                        onTapped: {
                            videoList.currentIndex = index
                            player.source = videoList.currentItem.filepath
                            player.play()
                            mediaDate.list_item_clicked(player.source);
                        }
                    }
                }
            }
        }

        Rectangle{
            width: parent.width*0.9
            height:parent.height*0.9
            x:parent.width*0.1
            y:parent.height*0.6
            color:"orange"
            Label {
                text:"合并列表（放入合并视频并点击）"
                width: parent.width
                height:parent.height*0.1
            }
            Rectangle{
                width:parent.width
                height:parent.height
                y:parent.height*0.05
                ListView{
                    id:_mergeVideolist
                    anchors.fill: parent
                    model:ListModel{
                        id:_mergefilesModel
                    }
                    delegate: Mergevediolist{id: mergeItem}
                }
                component Mergevediolist:Rectangle{
                    id:mergeRoot
                    property url filepath:mergefilePath
                    width:parent.width
                    height:20
                    Text{
                        verticalAlignment:Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        color: mergeRoot.ListView.isCurrentItem?"red":"black"
                        width:mergeItem.width
                        font.pixelSize: 13
                        text:filepath
                    }
                    TapHandler{
                        onTapped: {
                            _mergeVideolist.currentIndex = index
                            player.source = _mergeVideolist.currentItem.filepath
                            player.play()
                            myvideoOutput.focus = true
                            mediaDate.list_item_clicked(player.source);
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        filesModel.clear()
        //Controller.initial()
    }
    Dialog {
        id: _textInputDialogComponent
        title: "输入文字"
        anchors.centerIn: parent
        width: 300
        height: 150
        focus:true
        ColumnLayout {
            anchors.centerIn: parent
            TextField {
                id: textInput
                width: 250
                placeholderText: "请输入文字..."
            }
            RowLayout{
                Button {
                    text: "确认"
                    width: 80
                    onClicked: {
                        console.log("输入的文字: ", textInput.text)
                        mediaDate.addText(textInput.text)
                        textInput.clear()
                        _textInputDialogComponent.visible = false
                    }
                }
                Button {
                    text: "取消"
                    width: 80
                    onClicked: {
                        _textInputDialogComponent.visible = false
                    }
                }
            }
        }
    }

    Dialog {
        id:_saveDialogComponent
        title: "保存"
        anchors.centerIn: parent
        width: 400
        height: 200
        focus:true
        Column {

            anchors.centerIn: parent
            // TextEdit{
            //     text: "是否保存"
            // }
            TextField {
                id: textin
                width: 250
                placeholderText: "请输入文件名..."
            }
            Row{
                Button {
                    text: "OK"
                    width: 80
                    onClicked: {

                        _saveDialogComponent.visible = false
                        console.log("输入的文件名: ", textin.text)

                    }

                }
                Button {
                    text: "NO"
                    width: 80
                    onClicked: {
                        _saveDialogComponent.visible = false
                    }
                }
            }
        }
    }

    Dialog {
        id: _fadeout
        title: "淡出"
        anchors.centerIn: parent
        width: 300
        height: 150
        focus:true
        ColumnLayout {
            anchors.centerIn: parent
            RowLayout{
                TextField {
                    id: starttime2
                    width: 250
                    placeholderText: "淡出时间"
                }
                TextField {
                    id: duratime2
                    width: 250
                    placeholderText: "持续时间"
                }
            }
            RowLayout{
                Button {
                    text: "确认"
                    width: 80
                    onClicked: {
                        console.log("输入的秒数: ", starttime2.text)
                        _mediaDate.fadeout(multiPics.currentItem.source,starttime2.text,duratime2.text)
                        starttime2.clear()
                        duratime2.clear()
                        _fadeout.visible = false
                    }
                }
                Button {
                    //anchors.right: parent
                    text: "取消"
                    width: 80
                    onClicked: {
                        _fadeout.visible = false
                    }
                }
            }
        }
    }
    Dialog {
        id: _fadein
        title: "淡入"
        anchors.centerIn: parent
        width: 300
        height: 150
        focus:true
        ColumnLayout {
            anchors.centerIn: parent
            RowLayout{
                TextField {
                    id: starttime
                    width: 250
                    placeholderText: "淡入时间"
                }
                TextField {
                    id: duratime
                    width: 250
                    placeholderText: "持续时间"
                }
            }
            RowLayout{
                Button {
                    text: "确认"
                    width: 80
                    onClicked: {
                        console.log("输入的秒数: ", starttime.text)
                         _mediaDate.fadein(multiPics.currentItem.source,starttime.text,duratime.text)
                        starttime.clear()
                        duratime.clear()
                        _fadein.visible = false
                    }
                }
                Button {
                    //anchors.right: parent
                    text: "取消"
                    width: 80
                    onClicked: {
                        _fadein.visible = false
                    }
                }
            }
        }
    }
}

