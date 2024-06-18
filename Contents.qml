import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5


Item{
    //左侧导航栏
    Rectangle{
        id:leftMenu
        width: parent.width/5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //color: setColor(20, 20, 20,0.8)
        color: 'red'
     }
    //底部
    Rectangle{
        id:myFooter
        y:parent.height-height
        width: parent.width
        height: 40
        //color: videoPage.visible?setColor(0,0,0,0.6):setColor(43, 45, 47,0.95)
    color: 'green'

    }



}
