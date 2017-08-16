import QtQuick 2.0

Rectangle {
    id:root
    property string settingName
    property string job:func
    readonly property color defaultBackgroundColor: "transparent"
    property color backgroundColor: defaultBackgroundColor
    property color textColor: "white"
    property real fontScaler : 2.2

    signal clicked

    border.color: "lightblue"
    border.width: 3
    color:root.backgroundColor
    radius:40
    anchors.topMargin: 100

    Text{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        text:settingName
        width:parent.width
        wrapMode: Text.WordWrap
        font.pixelSize: Math.round(parent.height/fontScaler)
        font.bold: true
        color:textColor
    }
}
