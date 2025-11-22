import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Wayland
import qs.modules.common.widgets

PanelWindow {
    property string music: "Hello, world!"

    width: 480
    height: 430
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Bottom

    anchors {
        left: true
        bottom: true
    }

    MergedEdgeRect {
        color: "green"
        opacity: .5

        //cornerRadius: 40
        anchors {
            fill: parent
            topMargin: 10
            leftMargin: -10
        }
        Text {

            text: music
            font.pixelSize: 10
            color: '#5e0000'
        }

        Rectangle {
            opacity: 1
            //border.color: '#ff3a3a'
            //border.width: 5
            color: "transparent"

            anchors {
                fill: parent
            }

        }

        Process {
            //music += points[0];

            command: ["cava"]
            running: true

            stdout: SplitParser {
                onRead: (data) => {
                    let points = data.split(";").map((p) => {
                        return Math.round(parseFloat(p.trim()) / 20);
                    });
                    music = '\n    ' + '█'.repeat(points[0]);
                    for (let i=0; i<30;++i)
                    {
                        music += '\n    ' + '█'.repeat(points[i]);
                    }
                }
            }

        }

        /*Process {
            command: ["sensors > /dev/stdout"]
            running: true

            stdout: SplitParser {
                onRead: temp => {
                    temperature = temp;
                }
            }

        }*/

    }

}
