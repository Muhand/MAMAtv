import QtQuick 2.0

Item {
    id:channelinfo
    property color backgroundColor: "blue"
    property color headerBackgroundColor: "lightblue"
    property color headerNameColor: "black"
    property color borderColor: "black"
    property color channelNameColor: "white"
    property color channelNumberColor: "white"
    property real borderWidth:0
    property real radius:0
    property real backgroundOpacity: 0.5
    property string menuTitle : "TV Channels"
    property string channelNameProp
    property string channelNumberProp
    property url headerIcon: "imgs/television.png"

    visible:false

    Rectangle{
        id:root
        width:channelinfo.width
        height:channelinfo.height
        color:channelinfo.backgroundColor
        border.color:channelinfo.borderColor
        border.width: channelinfo.borderWidth
        radius:channelinfo.radius
        opacity:channelinfo.backgroundOpacity
        visible: parent.visible

        Rectangle{
            id:header
            anchors.top:parent.top
            //            width:(parent.width*40)/100
            width: parent.width
            height: (parent.height*30)/100
            radius: channelinfo.radius
            color:channelinfo.headerBackgroundColor
            Image{
                source:channelinfo.headerIcon
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -4
            }

            Text{
                id:headerTitle
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                width:parent.width
                wrapMode: Text.WordWrap
                color:channelinfo.headerNameColor
                text:menuTitle
                font.pixelSize: Math.round(parent.height/2)
                font.bold: true
            }
        }

        Rectangle{
            id:content
            anchors.bottom: parent.bottom
            width:parent.width
            height:parent.height-header.height
            color:"transparent"
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                color:channelinfo.channelNameColor
                text:channelNameProp
                font.pixelSize: Math.round(parent.height/4)
                font.bold: true
            }
            Text{
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color:channelinfo.channelNumberColor
                text:channelNumberProp
                font.pixelSize: Math.round(parent.height/4)
                font.bold: true
            }
        }
    }
}
