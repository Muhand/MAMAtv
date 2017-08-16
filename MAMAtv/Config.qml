pragma Singleton
import QtQuick 2.0
import QtQuick.XmlListModel 2.0

QtObject {
    property bool loaded:false
    property string currentChannelNum:"-1"
    property Channel currentChannel:Channel{

    }

    property XmlListModel channelsList:XmlListModel{
        id:dataSources
//        source:"http://www.muhandjumah.com/IPTV/channels.xml"
//        source:"home/muhand/Desktop/MAMAtv/build-MAMAtv-Desktop_Qt_5_7_0_GCC_64bit-Debug/config/channels.xml"
//        source: "config\\channels.xml"
        query:"/Channels/Channel"
        XmlRole{name:"ChannelName";query:"ChannelName/string()"}
        XmlRole{name:"ChannelID";query:"ChannelID/string()"}
        XmlRole{name:"ChannelURL";query:"ChannelURL/string()"}
        XmlRole{name:"ChannelNumber";query:"ChannelNumber/string()"}

        onStatusChanged: {
            if(status===XmlListModel.Loading)
            console.log("Still loading channels.xml")
            else if(status===XmlListModel.Ready)
            console.log("Channels are Ready")
            else if(status===XmlListModel.Error)
            console.log("XML Error"+errorString())
            else if(status === XmlListModel.Null)
            console.log("Something went wrong with the path and returned a null");
        }
    }
}
