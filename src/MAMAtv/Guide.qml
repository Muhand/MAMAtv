import QtQuick 2.0
import VLCQt 1.0
import QtQuick.XmlListModel 2.0
import "."

Rectangle{
    color:"lightblue"
    focus:true

    Keys.onPressed: {
        event.accepted = true;
        if(event.key === Qt.Key_Escape)
        {
            //            rootPageLoader.currentChannelURL="test";
            //            rootPageLoader.vidwidget.create();
            tt.destroy();
            rootPageLoader.source ="ChannelViewer.qml";
        }
        else if(event.key === Qt.Key_Return)
        {
            //                        changeChannel(menuContent.currentItem.ch_url, menuContent.currentItem.ch_name)
            //                        main.channelName="testaaa"
            //            channelName = menuContent.currentItem.ch_name
            //            channelURL = menuContent.currentItem.ch_url
            Config.currentChannelNum = menuContent.currentItem.ch_number;
            //            Config.currentChannel.ch_id = menuContent.currentItem.ch_id
            //            Config.currentChannel.ch_num = menuContent.currentItem.ch_num
            //            Config.currentChannel.ch_name = menuContent.currentItem.ch_name
            //            Config.currentChannel.ch_url = menuContent.currentItem.ch_url


//            tt.destroy()
            rootPageLoader.source ="ChannelViewer.qml";
        }
        else if(event.key === Qt.Key_Up)
        {
            if(menuContent.currentIndex > 0)
                menuContent.currentIndex= menuContent.currentIndex-1;
//            else if (menuContent.currentIndex === 0)
//                menuContent.currentIndex = menuContent.count-1;

        }
        else if(event.key === Qt.Key_Down)
        {
//            if(menuContent.currentIndex === menuContent.count-1)
//                menuContent.currentIndex = 0;
//            else
            if(menuContent.currentIndex < menuContent.count-1)
                menuContent.currentIndex= menuContent.currentIndex+1;
        }
    }


    Rectangle{
        color:"transparent"
        width: (parent.width*99)/100
        height: (parent.height*94)/100                //Left Rectangle
        anchors.centerIn: parent

        Rectangle{
            color:"transparent"
            width:(parent.width*49)/100
            height:parent.height
            anchors.left: parent.left

            Text{
                text:"TV Channels"
                anchors.top:parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                color:"black"
                font.pixelSize: Math.round(parent.height/24)
                font.bold: true
            }

            /////////////////////////////////////////////////////////
            //Channels List goes here
            /////////////////////////////////////////////////////////
            ListView{
                id:menuContent
                width:(parent.width*95)/100
                height:(parent.height*90)/100
                anchors.centerIn: parent
                spacing:70
                model:Config.channelsList
                delegate: GuideListItemDel
                {
                w:parent.width
                h:parent.height
                bgColor:ListView.isCurrentItem ? "yellow" : defaultColor
            }
            //            focus:true
        }
    }

    //Right Rectangle
    Rectangle{
        color:"transparent"
        width:(parent.width*50)/100
        height:parent.height
        anchors.right: parent.right

        Column{
            height:parent.height
            width: parent.width
            Text{
                //                        anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: new Date().toLocaleDateString()
                wrapMode: Text.WordWrap
                color:"black"
                font.pixelSize: Math.round(parent.height/24)
                font.bold: true
            }
        }

        Rectangle{
            color:"transparent"
            width:parent.width
            height:(parent.height*52.2)/100
            anchors.top:parent.top
            anchors.topMargin: 50

            VlcVideoPlayer {
                id:tt
                anchors.fill: parent
                url:Config.currentChannel.ch_url
            }

        }

        Rectangle{
            id: test
            color:"transparent"
            anchors.bottom: parent.bottom
            width:parent.width
            height:(parent.height*35.8)/100
            anchors.topMargin: 200
            anchors.leftMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            //Channel ID, Channel Name, Channel URL, Channel Number At bottom todays date

            Column{
                spacing:4
                height:parent.height
                width:parent.width
                Text{
                    text:"ID: " + menuContent.currentItem.ch_id
                    //                                text:"ID: 1"
                    //                                text:"ID: "+menuContent.currentItem.ChannelName
                    wrapMode: Text.WordWrap
                    color:"black"
                    //                                font.pixelSize: Math.round(test.height/2)
                    font.pixelSize: Math.round(parent.height/12)
                    font.bold: true
                    anchors.topMargin:10
                }
                Text{
                    //                                text:"Channel Name: MBC"
                    text:"Channel Name: "+ menuContent.currentItem.ch_name
                    wrapMode: Text.WordWrap
                    color:"black"
                    font.pixelSize: Math.round(parent.height/12)
                    font.bold: true
                    anchors.topMargin:10
                }
                Text{
                    //                                text:"Channel Number: 1"
                    text:"Channel Number: "+menuContent.currentItem.ch_number
                    wrapMode: Text.WordWrap
                    color:"black"
                    font.pixelSize: Math.round(parent.height/12)
                    font.bold: true
                    anchors.topMargin:10
                }
                Text{
                    //                                text:"Channel URL: http://xyz.com/abc.ts"
                    text:"Channel URL: "+menuContent.currentItem.ch_url
                    width:parent.width
                    wrapMode: Text.WordWrap
                    color:"black"
                    font.pixelSize: Math.round(parent.height/12)
                    font.bold: true
                    anchors.topMargin:10
                }
            }
        }
    }
}
}
