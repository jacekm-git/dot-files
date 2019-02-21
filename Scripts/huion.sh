#!/bin/sh

#Change DVI-I-1 to what monitor you want from running command: xrandr
MONITOR=$(xrandr | grep "HDMI" | grep -w "connected" | cut -c 1-5)


#define key bindings

xsetwacom --set 'HID 256c:006e Pad pad' Button 1 "key +"
xsetwacom --set 'HID 256c:006e Pad pad' Button 2 "key -"
xsetwacom --set 'HID 256c:006e Pad pad' Button 3 "key ]"
xsetwacom --set 'HID 256c:006e Pad pad' Button 8 "key ["
xsetwacom --set 'HID 256c:006e Pad pad' Button 9 "key ctrl ["
xsetwacom --set 'HID 256c:006e Pad pad' Button 10 "key ctrl ]"
xsetwacom --set 'HID 256c:006e Pad pad' Button 11 "key e"
xsetwacom --set 'HID 256c:006e Pad pad' Button 12 "key ctrl z"
xsetwacom --set 'HID 256c:006e Pad pad' Button 13 "key i"
xsetwacom --set 'HID 256c:006e Pad pad' Button 14 "key j"
xsetwacom --set 'HID 256c:006e Pad pad' Button 15 "key k"
xsetwacom --set 'HID 256c:006e Pad pad' Button 16 "key l"
ID_STYLUS=$(xinput | grep "HID 256c:006e Pen Pen (0)" | cut -f 2 | cut -c 4-5)

echo $ID_STYLUS
echo $MONITOR
xinput map-to-output $ID_STYLUS $MONITOR
