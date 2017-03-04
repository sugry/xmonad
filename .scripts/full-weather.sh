#!/bin/sh

notify-send -u normal -h int:x:500 -h int:y:500 -t 4000 -i /home/s-adm/.scripts/icon/surgut.png "    Погода в Сургуте    " "    $(tail -n 1 /home/s-adm/.scripts/weatmp)"


