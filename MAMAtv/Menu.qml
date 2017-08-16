import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import "."
import MAMAtv 1.0
Rectangle {

    function downloadNewChannels()
    {
//        var rawFile = new XMLHttpRequest();
//        rawFile.open("GET", "http://www.muhandjumah.com/IPTV/channels.xml", false);
//        rawFile.onreadystatechange = function ()
//        {
//            if(rawFile.readyState === 4)
//            {
//                if(rawFile.status === 200 || rawFile.status == 0)
//                {
//                    var allText = rawFile.responseText;
//                    var sw = new StreamWriter(filepathIncludingFileName);

//                    for(var curline = 0; curline < allText.length; curline++){

//                        sw.WriteLine(allText[curline]);
//                    }

//                    sw.Flush();
//                    sw.Close();

//                    console.log(allText);
//                }
//            }
//        }
//        console.log("Downloaded--------------------------------");
//        rawFile.send(null);
        writeToFile.source="abcasdafsdfds.txt";
        writeToFile.write("ABCASDFASDFASDFASDFASDF");
    }

    color:"blue"
    Keys.onPressed: {
        if(event.key === Qt.Key_Escape)
        {
            rootPageLoader.source = "ChannelViewer.qml";
        }
        else if(event.key === Qt.Key_Return)
        {
            if(menuContent.currentItem.job === "quit")
                rootPageLoader.source = "ChannelViewer.qml";
            else if(menuContent.currentItem.job === "download")
                downloadNewChannels();
        }

        event.accepted = true;
    }
    Rectangle{
        id:header
        anchors.top:parent.top
        width:parent.width
        height:(parent.height*10)/100
        color:"#c1ffe9"

        Rectangle{
            anchors.left: parent.left
            height: parent.height
            width: (parent.width*50)/100
            color:"transparent";

            Image{
                source:"imgs/settings_64x64.png"
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -4
                //                        width:(6400/parent.width)*10
                //                        width:(parent.width*30)/100
                //                        height:width
            }

            Text{
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                width:parent.width
                wrapMode: Text.WordWrap
                color:"Black"
                text:"Settings"
                font.pixelSize: Math.round(parent.height/2)
                font.bold: true
            }

        }
    }

    Rectangle{
        id:content
        color:"transparent"
        anchors.centerIn: parent
        height:parent.height- (footer.height+header.height)
        width:parent.width

        ListView{
            id:menuContent
            width:(parent.width*80)/100
            height: (parent.height*90)/100
            anchors.centerIn: parent
            spacing: 10
            focus:true
            model:MenuModel{}
            delegate: MenuButton
            {
            width:parent.width
            height:(menuContent.height*10)/100
//            :ListView.isCurrentItem ? "yellow" : defaultColor
            backgroundColor:ListView.isCurrentItem ? "lightblue" : defaultBackgroundColor
            settingName:text
        }


        FileIo{
            id:writeToFile
            onSourceChanged:{
                console.log(source);
            }
        }

        //        ListView {
        //            id:menuContent
        //            width:(parent.width*80)/100
        //            height: (parent.height*90)/100
        //            anchors.centerIn: parent
        //            spacing: 10
        //            Component {
        //                id: menuDelegate
        //                Rectangle {
        //                    id: wrapper
        //                    width: parent.width
        //                    height: contactInfo.height
        //                    anchors.horizontalCenter: parent.horizontalCenter
        //                    color: "transparent"

        //                    MenuButton{
        //                        id: contactInfo
        //                        width:parent.width
        //                        height:(menuContent.height*10)/100
        //                        backgroundColor:wrapper.ListView.isCurrentItem ? "lightblue" : defaultBackgroundColor
        //                        settingName:text

        //                        onClicked: {
        //                            Qt.quit()
        //                        }
        //                    }
        //                }
        //            }

        //            model: MenuModel {}
        //            delegate: menuDelegate
        //            focus: true
        //        }

    }
}
Rectangle{
    id:footer
    anchors.bottom:parent.bottom
    width:parent.width
    height:(parent.height*10)/100
    color:"#c1ffe9"
}

}
