import QtQuick 2.0

Item {
    id:volumeinfo
    property int currentVol
    property int mainBackgroundHeight:height
    property int mainBackgroundWidth:width
    readonly property int maxVolHeight:mainBackgroundHeight-20
    property color mainBackgroundColor: "black"
    property color volumeColor: "blue"
    //    visible:false
    Rectangle{
        height:mainBackgroundHeight
        width:mainBackgroundWidth
        color:"transparent"

        Text{
            id:volText
            color:"green"
            text:currentVol
            anchors{
                top:parent.top
                horizontalCenter: parent.horizontalCenter
            }
            wrapMode: Text.WordWrap
            font.pixelSize: Math.round(parent.height/30)
            font.bold: true
        }

        Rectangle{
            color:mainBackgroundColor
            height:parent.height-volText.height-5
            width:parent.width

            anchors{
                bottom: parent.bottom
            }


            Rectangle{
                color:volumeColor
//                height:currentVol+(parent.height/100)
                height:((((currentVol*100)/125)*parent.height)/100)-20
                width:40
                anchors{
                    bottom: parent.bottom
                    bottomMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
            }

        }
    }




}
