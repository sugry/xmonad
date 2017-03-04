#!/bin/sh

if test -f "/home/s-adm/.scripts/weatmp"; then notify-send -u normal -h int:x:500 -h int:y:500 -t 4000 -i /home/s-adm/.scripts/icon/surgut.png "Погода в Сургуте" "$(cat /home/s-adm/.scripts/weatmp | head -1)";fi


