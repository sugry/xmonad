#!/bin/bash

devoff='0'
A="$(xinput list-props "ETPS/2 Elantech Touchpad" | grep "Device Enabled" | sed 's/	Device Enabled (127):	//g')"
if [ $A == $devoff ]; then
      xinput enable "ETPS/2 Elantech Touchpad"
      notify-send -u normal -t 2000 -i /home/s-adm/.config/polybar/icon/input-touchpad-symbolic.svg "O" "Touchpad on"      
else
      xinput disable "ETPS/2 Elantech Touchpad"
      notify-send -u normal -t 2000 -i /home/s-adm/.config/polybar/icon/input-touchpad-symbolic.svg "X" "Touchpad off"
fi
