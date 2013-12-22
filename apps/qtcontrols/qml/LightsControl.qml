import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import Hue 0.1

GridLayout {
    id: layout
    columns: 2
    property var light

    onLightChanged: {
        effectCb.update();
    }

    Label {
        text: "Power: " + (light && light.on ? "On" : "Off")
    }
    Button {
        text: "toggle"
        Layout.fillWidth: true
        onClicked: {
            light.on = !light.on
        }
    }
    Label {
        text: "Brightness:"
    }
    Slider {
        Layout.fillWidth: true
        minimumValue: 0
        maximumValue: 255
        value: light ? light.bri : 0
        onValueChanged: {
            light.bri = value
        }
    }

    ColorPicker {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 2
        onColorChanged: {
            light.color = color;
        }
    }
    Label {
        text: "Effect:"
    }

    ComboBox {
        id: effectCb
        Layout.fillWidth: true
        textRole: "name"
        model: ListModel {
            id: effectModel
            ListElement { name: "No effect"; value: "none" }
            ListElement { name: "Color loop"; value: "colorloop" }
        }
        function update(){
            if (light === null || light === undefined) {
                effectCb.currentIndex = -1;
                return;
            }

            for (var i = 0; i < effectModel.count; i++) {
                if (effectModel.get(i).value == light.effect) {
                    effectCb.currentIndex = i;
                }
            }
            return effectCb.currentIndex = -1;
        }

        onCurrentIndexChanged: {
            if (light && currentIndex > -1) {
                light.effect = effectModel.get(currentIndex).value;
            }
        }
    }
}

