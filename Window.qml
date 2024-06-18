import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow{
 id:mainWindow
 visible:true
 property int windowWidth: Screen.desktopAvailableWidth*0.65    //窗口宽度，跟随电脑屏幕变化
 property int windowHeight: Screen.desktopAvailableHeight*0.75  //窗口高度，跟随电脑屏幕变化

 width: windowWidth
 height: windowHeight



 Contents{
     id:content
     anchors.fill: parent
 }


 }









