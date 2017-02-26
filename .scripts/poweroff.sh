#!/bin/sh
zenity  --question --text "Вы действительно желаете выключить компьтер?"
if [ $? = 0 ]
	then sudo poweroff
fi
exit 0
