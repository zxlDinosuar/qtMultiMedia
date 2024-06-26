import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "multiMedia.js" as Controller

Rectangle {
    width:parent.width
    height:parent.height
    property string times
    times: _hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text
    RowLayout{
        //implicitWidth: 100
        height: parent.height
        //implicitHeight: 30
        focus: true
        TextInput{
            id:_hourEditTop
            text:"00"
            height: parent.height
            //verticalAlignment: Text.AlignVCenter
            y:parent.height*0.33
            color:Qt.rgba(1,1,1,0.8)
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
            //verticalAlignment: Text.AlignVCenter
            y:parent.height*0.33
            color:Qt.rgba(1,1,1,0.8)
        }

        TextInput{
            id:_minuteEditTop
            text:"00"
            height: parent.height
            color:Qt.rgba(1,1,1,0.8)
            //verticalAlignment: Text.AlignVCenter
            y:parent.height*0.33
            TapHandler{
                onTapped:_cutStart.flags=1
            }
            //^表示开始，$表示结束，只能输入0-60
            validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
        }
        Text{
            text:":"
            height: parent.height
            //verticalAlignment: Text.AlignVCenter
            y:parent.height*0.33
            color:Qt.rgba(1,1,1,0.8)
        }
        TextInput{
            id:_secondEditTop
            text:"00"
            height: parent.height
            //verticalAlignment: Text.AlignVCenter
            y:parent.height*0.33
            color:Qt.rgba(1,1,1,0.8)
            TapHandler{
                onTapped:_cutStart.flags=2
            }
            //^表示开始，$表示结束，只能输入0-60
            validator: RegularExpressionValidator { regularExpression: /^([0-6]?[0-9])$/}
        }
        ColumnLayout{
            //height: parent.height
            Button{
                height:parent.height/5
                implicitWidth:10
                implicitHeight:10
                id:_forwardTop
                onClicked:{Controller.addTime(_hourEditTop,_minuteEditTop,_secondEditTop,_cutStart.flags)
                    times = _hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text}
            }
            Button{
                height:parent.height/5
                implicitWidth:10
                implicitHeight:10
                id:_backwardTop
                onClicked:{Controller.reduceTime(_hourEditTop,_minuteEditTop,_secondEditTop,_cutStart.flags)
                    times = _hourEditTop.text+":"+_minuteEditTop.text+":"+_secondEditTop.text}
            }
        }
    }

}
