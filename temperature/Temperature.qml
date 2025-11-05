import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Wayland

PanelWindow {
    property string temp: "Hello, world!"

    width: 100
    height: 100
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Bottom

    anchors {
        right: true
        bottom: true
    }

    Rectangle {
        color: "#aa701818"
        opacity: 1
        radius: 20

        anchors {
            fill: parent
            bottomMargin: 10
            rightMargin: 10
        }

        Text {
            text: temp
            font.pixelSize: 20
            color: "white"
            anchors.centerIn: parent
        }

        Rectangle {
            opacity: 1
            border.color: '#ff3a3a'
            border.width: 4
            color: "transparent"
            radius: 20

            anchors {
                fill: parent
            }

        }

        Process {
            command: ["cat", "/sys/class/thermal/thermal_zone1/temp"]
            running: true
            id: tempProc
            stdout: SplitParser {
                onRead: t => {
                    temp = (parseFloat(t)/1000) + '°C';
                }
            }
        }

        Timer {
            interval: 3000
            running: true
            repeat: true
            onTriggered: {
                tempProc.running = false;
                tempProc.running = true;
            }
        }

    }

}
