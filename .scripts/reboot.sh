#!/bin/sh
zenity  --question --text "Вы действительно желаете перезагрузить компьтер?"
if [ $? = 0 ]
	then sudo reboot
fi
exit 0
