import QtQuick 2.0
import "."  // this is needed when referencing singleton object from same folder
import QtQuick.XmlListModel 2.0
import MAMAtv 1.0

Item{
    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }
    function showChannelViewer()
    {
        //        if(Config.channelsList.status === XmlListModel.Ready)
        bootPageLoader.source="ChannelViewer.qml";
        //        else
        //            showChannelViewer();
    }

    Loader{
        id: bootPageLoader
        anchors.fill:parent
        sourceComponent: bootSystem
        focus:true
    }

    Component{
        id:bootSystem

        Rectangle{
            width: 640
            height: 480
            color:"black"
            focus:true

            Component.onCompleted: {
                booting.load();
            }

            Boot{
                id:booting


                onConfigLoadedSuccessfully:{
                    console.log("Config file loaded successfully");

                    Config.currentChannelNum = currentChannelNum;

                    //                    showChannelViewer();
                }
                onErrorOccuredChanged:{
                    if(errorOccured === true)
                        console.log("BOOT ERROR: " + errorMsg);
                }
                onErrorMsgChanged: {
                    console.log("New Boot Log Message: " + errorMsg);
                    logModel.append({msg:errorMsg});
                    log.positionViewAtEnd();


                }
                onXmlContentChanged: {
                    Config.channelsList.xml = xmlContent;

                    delay(2000, function(){

                        var ch = Config.channelsList.get(Config.currentChannelNum-1);

                        Config.currentChannel.ch_id = ch.ChannelID;
                        Config.currentChannel.ch_num = ch.ChannelNumber;
                        Config.currentChannel.ch_name = ch.ChannelName;
                        Config.currentChannel.ch_url = ch.ChannelURL;

                        console.log(Config.currentChannel.ch_id);
                        console.log(Config.currentChannel.ch_num);
                        console.log(Config.currentChannel.ch_name);
                        console.log(Config.currentChannel.ch_url);

                        showChannelViewer();
                    })
                }

            }

            ListView {
                id:log
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin:10
                anchors.top: parent.top
                width:(parent.width*40)/100
                height:parent.height-20

                model: BootLogModel{
                    id:logModel
                }
                delegate: Text {
                    text: msg
                    color: "green"
                    font.pixelSize: 15
                }
            }

            Text{
                id: loading
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                text: "LOADING..."
                color: "white"
                font.pixelSize: Math.round(parent.height/20)
                font.bold: true
            }


        }
    }
}



//////////////////////////////////////////////////////////////////
//import QtQuick 2.0
//import VLCQt 1.0
//import "."  // this is needed when referencing singleton object from same folder
//import QtQuick.XmlListModel 2.0

//Item{


//    Timer {
//        id: timer
//    }

//    function delay(delayTime, cb) {
//        timer.interval = delayTime;
//        timer.repeat = false;
//        timer.triggered.connect(cb);
//        timer.start();
//    }


//    function loadConfigFile()
//    {
//        var rawFile = new XMLHttpRequest();
//        rawFile.open("GET", "file:///config/config.cfg", false);
//        rawFile.onreadystatechange = function ()
//        {
//            if(rawFile.readyState === 4)
//            {
//                if(rawFile.status === 200 || rawFile.status == 0)
//                {
//                    var allText = rawFile.responseText;

//                    var properties = allText.split('\n');

//                    for(var curline = 0; curline < properties.length; curline++){
//                        if(properties[curline] !== "")
//                        {
//                            var line = properties[curline].split("=")
//                            var prop = line[0];
//                            var value = line[1];

//                            if(prop === "LastChannel")
//                                Config.currentChannelNum = value;

//                            console.log(prop);
//                        }
//                    }

//                }
//            }
//        }
//        console.log("LOADED--------------------------------");
//        rawFile.send(null);

//    }

//    function channelsAreLoaded()
//    {
//        if(Config.channelsList.status === XmlListModel.Ready)
//            return true;
//        else
//        {
//            return false;
//        }
//    }

//    function showChannelViewer()
//    {
//        if(Config.channelsList.status === XmlListModel.Ready)
//            bootPageLoader.source="ChannelViewer.qml";
//        else
//            showChannelViewer();
//    }

//    Loader{
//        id: bootPageLoader
//        anchors.fill:parent
//        sourceComponent: bootSystem
//        focus:true
//    }

//    Component{
//        id:bootSystem
//        Rectangle{
//            width: 640
//            height: 480
//            color:"black"

//            Text{
//                id: loading
//                anchors{
//                    horizontalCenter: parent.horizontalCenter
//                    verticalCenter: parent.verticalCenter
//                }

//                text: "LOADING..."
//                color: "white"
//                font.pixelSize: Math.round(parent.height/20)
//                font.bold: true
//            }

////            console.log(Config.currentChannel.ch_name);
//            Component.onCompleted: {

//                loadConfigFile();

//                //                while(Config.channelsList.status === XmlListModel.Loading)
//                //                {
//                //                    if(Config.channelsList.status === XmlListModel.Ready)
//                //                    {
//                //                        console.log("YEASSSSSSSSSSSSSSSSSSSSSSSSSS");
//                //                        break;
//                //                    }

//                //                    console.log("loading........");
//                //                }


//                delay(1000, function() {
////                    console.log("Changing to a specific channel");
////                    console.log(Config.channelsList.get(0).ChannelName);
//                    var ch = Config.channelsList.get(Config.currentChannelNum-1);

////                    console.log(ch.ChannelID);
////                    console.log(ch.ChannelNumber);
////                    console.log(ch.ChannelName);
////                    console.log(ch.ChannelURL);

//                    Config.currentChannel.ch_id = ch.ChannelID;
//                    Config.currentChannel.ch_num = ch.ChannelNumber;
//                    Config.currentChannel.ch_name = ch.ChannelName;
//                    Config.currentChannel.ch_url = ch.ChannelURL;

//                    console.log(Config.currentChannel.ch_id);
//                    console.log(Config.currentChannel.ch_num);
//                    console.log(Config.currentChannel.ch_name);
//                    console.log(Config.currentChannel.ch_url);

//                })

//                delay(1000, function() {
//                    console.log("Changing to channels");
//                    showChannelViewer();
//                })
//            }
//        }
//    }
//}

///////////////////////////////////
//The one on top is the real
////////////////////////////////////



//Rectangle {
//    //    id:root
//    width: 640
//    height: 480
//    color: "black"

//    function loadConfigFile()
//    {
//        var rawFile = new XMLHttpRequest();
//        rawFile.open("GET", "config/config.cfg", false);
//        rawFile.onreadystatechange = function ()
//        {
//            if(rawFile.readyState === 4)
//            {
//                if(rawFile.status === 200 || rawFile.status == 0)
//                {
//                    var allText = rawFile.responseText;

//                    var properties = allText.split('\n');

//                    for(var curline = 0; curline < properties.length; curline++){
//                        if(properties[curline] !== "")
//                        {
//                            var line = properties[curline].split("=")
//                            var prop = line[0];
//                            var value = line[1];

//                            if(prop === "LastChannel")
//                                Config.currentChannelNum = value;
//                        }
//                    }

//                }
//            }
//        }
//        console.log("LOADED--------------------------------");
//        rawFile.send(null);
//    }

//    function selectChannel()
//    {

//    }

//    function showChannelViewer()
//    {
//        bootPageLoader.source="ChannelViewer.qml";
//        //        root.destroy();
//    }

//    Component.onCompleted:{
//        loadConfigFile();


//        showChannelViewer();

//    }

//    Loader{
//        id:bootPageLoader
//        anchors.fill: parent
//        sourceComponent: loading
//        //        focus:true
//    }

//    Component{

//        id:loading
//        Text{
//            anchors{
//                horizontalCenter: parent.horizontalCenter
//                verticalCenter: parent.verticalCenter
//            }

//            text: "LOADING..."
//            color: "white"
//            font.pixelSize: Math.round(parent.height/20)
//            font.bold: true
//        }
//    }
//}

