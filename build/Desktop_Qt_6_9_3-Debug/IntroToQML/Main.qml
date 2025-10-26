import QtQuick

Window {

    id: root

    // TODO: change the size to ensure it forms the standard business card ratio of approx 1:1.586
    // HINT: you may wish to use a binding

    width: 1.586 * root.height
    height: 480

    visible: true
    title: qsTr("Business Card")
    color: colorTheme.windowColor

    component ContactInfo: QtObject {

        // This is a ContactInfo object which provides the properties to fill in.
        // You can create as many instances of this as you like with different property values.

        // show these properties all the time:
        property string name
        property url photo

        // Basic Info properties:
        property string occupation
        property string company

        // Detailed Info properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }

    ContactInfo {
        id: myContactInfo

        // this is one example instance of a ContactInfo inline Component
        // showing how the properties are populated.

        name: "Your Name"
        photo: Qt.resolvedUrl("IDPhoto.png")
        occupation: "QML Enthusiast"
        company: "Indie Soft"
        address: "Candy Cane Lane"
        country: "North Pole"
        phone: "+01 2345 567 890"
        email: "email@server.com"
        webSite: Qt.url("https://www.qt.io")
    }

    property bool stateDetails: true

    component ColorTheme: QtObject {
        property color titleTextColor
        property color headingTextColor
        property color bodyTextColor
        property color windowColor
        property color cardBorderColor
        property color cardColor
        property color imageBorderColor
        property color imageColor
        property color buttonDetailsColor
        property color buttonBaseColor
        property color buttonBorderColor
        property color buttonTextDetailsColor
        property color buttonTextBaseColor
        property color linkColor
    }

    ColorTheme {
        id: colorTheme
        titleTextColor: Qt.rgba(0, 0, 0, 1);
        headingTextColor: Qt.rgba(0, 0, 0, 1);
        bodyTextColor: Qt.rgba(0, 0, 0, 1);
        windowColor: Qt.rgba(1, 1, 1, 1);
        cardBorderColor: Qt.rgba(0, 0, 0, 1);
        cardColor: Qt.rgba(1, 1, 1, 1);
        imageBorderColor: Qt.rgba(0, 0, 0, 1);
        imageColor: Qt.rgba(1, 1, 1, 1);
        buttonDetailsColor: Qt.rgba(1, 1, 1, 1);
        buttonBaseColor: Qt.rgba(0, 0, 0, 1);
        buttonBorderColor: Qt.rgba(0, 0, 0, 1);
        buttonTextDetailsColor: Qt.rgba(0, 0, 0, 1);
        buttonTextBaseColor: Qt.rgba(1, 1, 1, 1);
        linkColor: Qt.rgba(0, 0, 1, 1);
    }

    component TitleText: Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        font.pixelSize: 36
        color: colorTheme.titleTextColor
    }

    component HeadingText: Text {
        anchors.left: parent.left
        anchors.margins: 10
        font.pixelSize: 24
        color: colorTheme.headingTextColor
    }

    component BodyText: Text {
        anchors.left: parent.left
        anchors.margins: 10
        font.pixelSize: 12
        color: colorTheme.bodyTextColor
    }

    component Button: Rectangle {
        id: buttonDetails
        color: (root.stateDetails) ? colorTheme.buttonDetailsColor : colorTheme.buttonBaseColor
        height: root.height / 10
        width: root.width / 5
        radius: buttonDetails.height / 2
        border.color: colorTheme.buttonBorderColor
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 10

        property alias textButton: textB.text

        Text {
            id: textB
            anchors.centerIn: parent
            color: (root.stateDetails) ? colorTheme.buttonTextDetailsColor : colorTheme.buttonTextBaseColor
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.stateDetails = !root.stateDetails
            }
        }
    }

    Rectangle {
        border.color: colorTheme.cardBorderColor
        color: colorTheme.cardColor
        radius: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        height: parent.height
        width: parent.width

        TitleText {
            id: nameText
            text: myContactInfo.name
        }

        Rectangle {
            height: parent.height / 2
            width: parent.width / 3
            radius: 10
            border.color: colorTheme.imageBorderColor
            color: colorTheme.imageColor
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10

            Image {
                source: myContactInfo.photo
                anchors.fill: parent
            }
        }

        HeadingText {
            id: occupationText
            text:  myContactInfo.occupation
            anchors.top: nameText.bottom
            visible: !root.stateDetails
        }

        HeadingText {
            id: companyText
            text: myContactInfo.company
            anchors.top: occupationText.bottom
            visible: !root.stateDetails
        }

        HeadingText {
            id: addressText
            text: myContactInfo.address
            anchors.top: nameText.bottom
            visible: root.stateDetails
        }

        HeadingText {
            id: countryText
            text: myContactInfo.country
            anchors.top: addressText.bottom
            visible: root.stateDetails
        }

        BodyText {
            id: phoneText
            text: myContactInfo.phone
            anchors.top: countryText.bottom
            visible: root.stateDetails
        }

        BodyText {
            id: emailText
            text: myContactInfo.email
            anchors.top: phoneText.bottom
            visible: root.stateDetails
        }

        BodyText {
            id: websiteText
            text: myContactInfo.webSite
            anchors.top: emailText.bottom
            visible: root.stateDetails
            color: colorTheme.linkColor
            font.underline: true
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally(parent.text)
                }
            }
        }

        Button {
            textButton: "Details"
        }
    }

    /* Your solution should contain these key features:

        - A Text element for each of the ContactInfo properties.
        - The name and photo image should be shown all the time.
        - These should be grouped into two categories "Basic Info" and "Details".
        - Create a button using a MouseArea or TapHandler that can be used to
          toggle between showing the two categories of information.
        - Use a larger font size for the name
    */
}
