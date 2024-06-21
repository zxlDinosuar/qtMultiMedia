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
    property alias mediaDate:_mediaDate
    property alias audioOutput: _audioOutput
    property alias progressSlider:_progressSlider
    property alias cutStart: _cutStart
    property alias cutEnd: _cutEnd
    property alias split:_split

    Dialogs {
        id:_allDialogs
        fileOpen.onAccepted: Controller.setFilesModel(fileOpen.selectedFiles)
        fileOpen1.onAccepted: Controller.setFileModel(fileOpen1.selectedFiles)
    }

    MediaDate {
        id:_mediaDate
        onAddToVideoList:{(outputPath)=> {
                Controller.addtoVideoList(outputPath, filesModel)
            }}
    }

    Rectangle{//left
        width: parent.width*0.7
        height:parent.height
        // property int  flags
        Rectangle{
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
            Rectangle{
                width:parent.width*0.5
                height:parent.height
                x:parent.width*0.5
                Rectangle{
                    id:_leftTop_right_top
                    width:parent.width
                    height:parent.height*0.5
                    RowLayout{
                        id:_cutStart
                        property int  flags
                        property string  starttime //用于存储剪切开始时间的字符串
                        starttime: _hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text
                        width:parent.width
                        height:parent.height/4
                        Label
                        {
                            width:parent.width/10
                            height: parent.height
                            text:"剪切开始："
                            color:"black"
                            leftPadding: parent.width/8
                        }
                        //实现QTimeEdit相似的功能
                        RowLayout{
                            x:parent.width/10
                            width:parent.width*0.9
                            height: parent.height
                            focus: true
                            TextInput{
                                id:_hourEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:{
                                        _cutStart.flags=0;
                                    }
                                }
                                //^表示开始，$表示结束，只能输入0-24
                                validator: RegularExpressionValidator { regularExpression: /^([01]?[0-9]|2[0-4])$/}
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_minuteEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:_cutStart.flags=1
                                }
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_secondEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:_cutStart.flags=2
                                }
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardTop
                                    onClicked:{
                                        Controller.addTime(_hourEditTop,_minuteEditTop,_secondEditTop,_cutStart.flags);
                                        cutStart.starttime =_hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text;
                                    }
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardTop
                                    onClicked: {
                                        Controller.reduceTime(_hourEditTop,_minuteEditTop,_secondEditTop,_cutStart.flags);
                                        cutStart.starttime = _hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text;
                                    }
                                }
                            }
                        }
                    }
                    RowLayout{
                        id:_cutEnd
                        property int  flags
                        property string endTime//剪切结束时间
                        endTime:_hourEditCenter.text+":"+_minuteEditCenter.text+":"+_secondEditCenter.text
                        y:parent.height/4
                        width:parent.width
                        height:parent.height/4
                        Label
                        {
                            width:parent.width/10
                            height: parent.height
                            text:"剪切结束："
                            color:"black"
                            leftPadding: parent.width/8
                        }
                        //实现QTimeEdit相似的功能
                        RowLayout{
                            focus: true
                            x:parent.width/10
                            width:parent.width*0.9
                            height: parent.height
                            TextInput{
                                id:_hourEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-24
                                validator: RegularExpressionValidator { regularExpression: /^([01]?[0-9]|2[0-4])$/}
                                TapHandler{
                                    onTapped:_cutEnd.flags=0
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_minuteEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                                TapHandler{
                                    onTapped:_cutEnd.flags=1
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_secondEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                                TapHandler{
                                    onTapped:_cutEnd.flags=2
                                }
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardCenter
                                    onClicked:{
                                        Controller.addTime(_hourEditCenter,_minuteEditCenter,_secondEditCenter,_cutEnd.flags);
                                        cutEnd.endTime = _hourEditCenter.text+":"+_minuteEditCenter.text+":"+_secondEditCenter.text;
                                    }
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardCenter
                                    onClicked: {Controller.reduceTime(_hourEditCenter,_minuteEditCenter,_secondEditCenter,_cutEnd.flags);
                                        cutEnd.endTime = _hourEditCenter.text+":"+_minuteEditCenter.text+":"+_secondEditCenter.text;
                                    }
                                }
                            }
                        }

                    }

                }
                Rectangle{
                    id:_leftTop_rightBottom
                    width:parent.width
                    height:parent.height/2
                    y:parent.height/2
                    RowLayout{
                        id:_split
                        property int  flags
                        property string breakTime//拆分节点时间
                        breakTime:_hourEditBottom.text+":"+_minuteEditBottom.text+":"+_minuteEditBottom.text
                        width:parent.width
                        height:parent.height/4
                        Label
                        {
                            width:parent.width/10
                            height: parent.height
                            text:"拆分节点："
                            color:"black"
                            leftPadding: parent.width/8
                        }
                        //实现QTimeEdit相似的功能
                        RowLayout{
                            focus:true
                            x:parent.width/10
                            width:parent.width*0.9
                            height: parent.height
                            TextInput{
                                id:_hourEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-24
                                validator: RegularExpressionValidator { regularExpression: /^([01]?[0-9]|2[0-4])$/}
                                TapHandler{
                                    onTapped:_split.flags=0
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_minuteEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                                TapHandler{
                                    onTapped:_split.flags=1
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextInput{
                                id:_secondEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                //^表示开始，$表示结束，只能输入0-60
                                validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
                                TapHandler{
                                    onTapped:_split.flags=2
                                }
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardBottom
                                    onClicked:{Controller.addTime(_hourEditBottom,_minuteEditBottom,_secondEditBottom,_split.flags);
                                        split.breakTime = _hourEditBottom.text+":"+_minuteEditBottom.text+":"+_minuteEditBottom.text;}
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardBottom
                                    onClicked:{Controller. reduceTime(_hourEditBottom,_minuteEditBottom,_secondEditBottom,_split.flags)
                                        split.breakTime=_hourEditBottom.text+":"+_minuteEditBottom.text+":"+_minuteEditBottom.text}
                                }
                            }
                        }

                    }

                }
            }
        }
        Rectangle{
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
        Rectangle{
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
                    x:parent.width*0.9
                    text:"添加特效"
                    height:parent.height
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
                                Controller.singleView()
                            }
                        }

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
                            Controller.exit_singleView()
                        }
                    }
                }
            }
        }
    }
    Rectangle{
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
                        font.pixelSize: 18
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
            }
        }
    }

    Component.onCompleted: {
        filesModel.clear()
        //Controller.initial()
    }
}

