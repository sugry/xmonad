#!/bin/sh
zenity  --question --text "Вы действительно желаете перевести компьтер в ждущий режим?"
if [ $? = 0 ]
	then systemctl suspend
fi
exit 0
