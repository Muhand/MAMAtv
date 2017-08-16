import QtQuick 2.0

Item {
    property real w
    property real h
    property color defaultColor:"lightblue"
    property color bgColor:defaultColor
    property string ch_name:ChannelName
    property string ch_number: ChannelNumber
    property string ch_id: ChannelID
    property string ch_url: ChannelURL

    Rectangle{
        width:w
        height:50
//        color:"red"
        color:bgColor
        radius:40
        border.color:"lightblue"
        border.width: 3
        anchors.topMargin: 100
        focus:true


        Text{
            anchors{
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 20
            }
            text:ch_number + " - " + ch_name
            width:parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: Math.round(parent.height/2.7)
            font.bold: true
            color:"black"

            MouseArea{
                anchors.fill: parent
                z:1
                onClicked: {
                    console.log(ch_name);
                }
            }

        }

    }

}
