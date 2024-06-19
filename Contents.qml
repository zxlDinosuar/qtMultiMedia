import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Rectangle{
        id:_left
        width: parent.width*0.7
        height:parent.height
        color:"red"
        Rectangle{
            id:_leftTop
            width:parent.width
            height:parent.height*0.5
            color:"yellow"
            Rectangle{
                          id:_mediaPlayer
                          width:parent.width/2
                          height:parent.height
                          color:"red"
                      }
                      Rectangle{
                          width:parent.width/2
                          height:parent.height
                          x:parent.width/2
                          color:"yellow"
                          Rectangle{
                              id:_leftTop_rightTop
                              color:"blue"
                              width:parent.width
                              height:parent.height/2
                              // Row{
                              //     Label:"剪切文件"
                              // }

                          }
                          Rectangle{
                              id:_leftTop_rightBottom
                              color:"orange"
                              width:parent.width
                              height:parent.height/2
                              y:parent.height/2
                          }
                      }
        }
        Rectangle{
            id:_leftCenter
            width:parent.width
            height:parent.height*0.1
            y:parent.height*0.5
            color:"black"
        }
        Rectangle{
            id:_leftBottom
            width:parent.width
            height:parent.height*0.4
            y:parent.height*0.6
            color:"blue"
            Rectangle{
                id:_leftBottomtop
                width:parent.width
                height:parent.height*0.1
                color: "white"
                Text{
                    height:parent.height
                    text:"素材库"
                    verticalAlignment: Text.AlignVCenter
                }
                Button{
                    x:parent.width*0.9
                    text:"添加特效"
                    height:parent.height
                    // verticalAlignment: Text.AlignVCenter
                }
            }
            Rectangle{
                id:_leftBottombottom
                width:parent.width
                height:parent.height*0.9
                color: "black"
                y:parent.height*0.1
            }
        }
    }
    Rectangle{
        id:_right
        x:parent.width*0.7
        width: parent.width*0.3
        height:parent.height
        color:"blue"
        Rectangle{
            id:_rightTop
            width:parent.width
            height:parent.height*0.5
            color:"white"
            Text{
                text:"视频列表"
            }
        }
        Rectangle{
            id:_rightBottom
            width: parent.width*0.9
            height:parent.height*0.9
            x:parent.width*0.1
            y:parent.height*0.6
            color:"orange"
            Text{
                text:"合并列表（放入合并视频并点击）"
            }
        }
    }
}

