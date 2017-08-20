import QtQuick 2.0
import VLCQt 1.0
import "."  // this is needed when referencing singleton object from same folder

Rectangle {
    id:root
    width: 640
    height: 480
    color: "black"


    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }


    Loader{
        id:rootPageLoader
        anchors.fill: parent
        focus:true

//        MouseArea{
//            anchors.fill: parent
//            enabled:false
//            cursorShape: Qt.BlankCursor
//        }

//        Component.onCompleted:{
//            if(Config.loaded === false)
//            {
//                Config.loaded = true;
//                loadConfigFile();
//            }
//        }

        Keys.onPressed: {
            event.accepted = true;
            if(event.key === Qt.Key_I)
            {
                if(channelInfo.visible === true)
                {
                    channelInfo.visible=false;
                    var vis = false;
                }
                else
                {
                    channelInfo.visible=true;

                    vis = true;

                    if(vis)
                    {
                        delay(3000, function() {
                            channelInfo.visible=false;
                            vis = false;
                        })
                    }
                }
            }
            else if(event.key === Qt.Key_PageUp)
            {
                if(vidwidget.volume < 125)
                    vidwidget.volume = vidwidget.volume+1;

                vis = true;

                if(volumeInfo.visible===false)
                    volumeInfo.visible=true;

                if(vis)
                {
                    delay(3000, function() {
                        volumeInfo.visible=false;
                        vis = false;
                    })
                }

            }
            else if(event.key === Qt.Key_PageDown)
            {
                if(vidwidget.volume >0)
                    vidwidget.volume = vidwidget.volume-1;

                vis = true;

                if(volumeInfo.visible===false)
                    volumeInfo.visible=true;

                if(vis)
                {
                    delay(3000, function() {
                        volumeInfo.visible=false;
                        vis = false;
                    })
                }

            }
            else if(event.key === Qt.Key_Up)
            {
                if(Config.currentChannelNum < Config.channelsList.count)
                {
                    var ch = Config.channelsList.get(Config.currentChannelNum);
                    Config.currentChannelNum = parseInt(Config.currentChannelNum)+1;

                    Config.currentChannel.ch_id = ch.ChannelID;
                    Config.currentChannel.ch_num = ch.ChannelNumber;
                    Config.currentChannel.ch_name = ch.ChannelName;
                    Config.currentChannel.ch_url = ch.ChannelURL;

                    vis = true;

                    if(channelInfo.visible===false)
                        channelInfo.visible=true;

                    if(vis)
                    {
                        delay(3000, function() {
                            channelInfo.visible=false;
                            vis = false;
                        })
                    }
                }
            }
            else if(event.key === Qt.Key_Down)
            {
                if(Config.currentChannelNum > 1)
                {
                    ch = Config.channelsList.get(Config.currentChannelNum-2);
                    Config.currentChannelNum = parseInt(Config.currentChannelNum)-1;

                    Config.currentChannel.ch_id = ch.ChannelID;
                    Config.currentChannel.ch_num = ch.ChannelNumber;
                    Config.currentChannel.ch_name = ch.ChannelName;
                    Config.currentChannel.ch_url = ch.ChannelURL;


                    vis = true;

                    if(channelInfo.visible===false)
                        channelInfo.visible=true;

                    if(vis)
                    {
                        delay(3000, function() {
                            channelInfo.visible=false;
                            vis = false;
                        })
                    }
                }
            }

            else if(event.key === Qt.Key_G)
            {
                vidwidget.destroy();
                rootPageLoader.source = "Guide.qml";
            }
            else if(event.key === Qt.Key_M)
            {
                vidwidget.destroy();
                rootPageLoader.source = "Menu.qml";
            }
        }

        VlcVideoPlayer {
            id: vidwidget
            anchors.fill: parent
            url:Config.currentChannel.ch_url
            //            autoplay:false
            //            vidwidget.play:0

            onVolumeChanged:{
                //                console.log(vidwidget.volume);
                volumeInfo.currentVol=vidwidget.volume;
            }
            ChannelInfo{
                id:channelInfo
                anchors.bottom: parent.bottom
                anchors.bottomMargin: ((parent.height*5)/100)
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width - ((parent.width*10)/100)
                height: (parent.height*20)/100
                backgroundOpacity: 0.7
                radius:10
                channelNameProp: Config.currentChannel.ch_name
                channelNumberProp: Config.currentChannel.ch_num
                headerIcon: "imgs/television_32x32.png"
            }

            VolumeInformation{
                id:volumeInfo
                visible:false
                currentVol: vidwidget.volume
                mainBackgroundColor: "red"
                anchors{
                    right:parent.right
                    rightMargin: 50
                    verticalCenter: parent.verticalCenter
                }

                height:(parent.height*90/100)
                width:60

            }
        }
    }
}

