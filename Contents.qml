import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "multiMedia.js" as Controller
import QtMultimedia

Item {
    property alias dialogs: _allDialogs
    property alias player: _player
    property alias videoList: _videoList
    // property alias footer: _footer
    property alias audioOutput: _audioOutput
    property alias progressSlider:_progressSlider

    Dialogs {
        id:_allDialogs
        fileOpen.onAccepted: Controller.setFilesModel(fileOpen.selectedFiles)
    }

    Rectangle{//left
        width: parent.width*0.7
        height:parent.height
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

                // TapHandler {
                //     onTapped: myvideoOutput.focus = true
                // }
            }
            Rectangle{
                width:parent.width*0.5
                height:parent.height
                x:parent.width*0.5
                Rectangle{
                    id:_leftTop_right_top
                    // property int flag
                    width:parent.width
                    height:parent.height*0.5
                    RowLayout{
                        id:_cutStart
                        focus: true
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
                            focus: true
                            x:parent.width/10
                            width:parent.width*0.9
                            height: parent.height
                            TextInput{
                                id:_hourEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:flags=0
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }

                            TextEdit{
                                id:_minuteEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:flags=1
                                }
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextEdit{
                                id:_secondEditTop
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                TapHandler{
                                    onTapped:flags=2
                                }
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardTop
                                    onClicked:Controller.addTime(_hourEditTop,_minuteEditTop,_secondEditTop,flags)
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardTop
                                    onClicked: Controller.reduceTime(_hourEditTop,_minuteEditTop,_secondEditTop,flags)
                                }
                            }
                        }
                    }
                    RowLayout{
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
                            TextEdit{
                                id:_hourEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }

                            TextEdit{
                                id:_minuteEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextEdit{
                                id:_secondEditCenter
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardCenter
                                    onClicked:Controller.addTime(_hourEditCenter,_minuteEditCenter,_secondEditCenter)
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardCenter
                                    onClicked: Controller.reduceTime(_hourEditCenter,_minuteEditCenter,_secondEditCenter)
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
                            TextEdit{
                                id:_hourEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }

                            TextEdit{
                                id:_minuteEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text{
                                text:":"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextEdit{
                                id:_secondEditBottom
                                text:"00"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }
                            ColumnLayout{
                                height: parent.height
                                Button{
                                    topPadding: 10
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_forwardBottom
                                    onClicked:Controller.addTime(_hourEditBottom,_minuteEditBottom,_secondEditBottom)
                                }
                                Button{
                                    implicitWidth:10
                                    implicitHeight:10
                                    id:_backwardBottom
                                    onClicked:Controller. reduceTime(_hourEditBottom,_minuteEditBottom,_secondEditBottom)
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
                    end = progressSlider.position
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
            color:"blue"
            Rectangle{
                width:parent.width
                height:parent.height*0.1
                color: "white"
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
                color: "black"
                y:parent.height*0.1
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
        Controller.initial()
    }
}

