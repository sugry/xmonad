#!/bin/sh

# author http://welinux.ru/post/1294/

# Sleep 1 minute

SLEEP_INTERVAL=60

while :; do
	# процент заряда
	BATT_PERCENT="$(acpi -b | awk "{print $1}" | sed 's/\([^:]*\): \([^,]*\), \([0-9]*\)%.*/\3/')"
	# статус - заряжается/разряжается
	BATT_STATUS="$(acpi -b | awk "{print $1}" | sed 's/\([^:]*\): \([^,]*\), \([0-9]*\)%.*/\2/')"

	S2='Discharging'
#	для отладки
#	echo $BATT_STATUS
#	echo $S2

	if [ $BATT_STATUS == $S2 ];
        then
        SLEEP_INTERVAL=60;
        	if [ $BATT_PERCENT -le "10" ];
 				# при 12 - 5% бук выключается, поэтому пора падать в ждущий режим
				then

				notify-send -u critical -i \
				/home/s-adm/.scripts/icon/battery-caution-symbolic.svg \
				"В Н И М А Н И Е !"  "Критический разряд батареи! Осталось всего ${BATT_PERCENT} % \
				Включите зарядное устройство иначе через 30 секунд компьютер перейдет в ждущий режим!";
				# даем 30 секунд времени на подключение зарядки
				sleep 30;
				# еще раз проверяем статус - не включилась ли зарядка
				WHATBATT="$(acpi -b | awk "{print $1}" | sed 's/\([^:]*\): \([^,]*\), \([0-9]*\)%.*/\2/')"
					# если не включилась - уходим в ждущий режим, иначе не уходим
					if [ $WHATBATT == $S2 ];
        				then
							systemctl suspend

					fi
				# собщения о низком заряде
				elif [ $BATT_PERCENT -le "15" ]; then

 				notify-send -u normal -t 10000 -i \
				/home/s-adm/.scripts/icon/battery-empty-symbolic.svg \
				"СОСТОЯНИЕ БАТАРЕИ"  "Низкий заряд батареи! Осталось всего ${BATT_PERCENT} % \
				Включите зарядное устройство!";
				# короткие напоминания заранее (можно и не делать)
				elif [ $BATT_PERCENT -le "30" ]; then

 				notify-send -u normal -t 5000 -i \
				/home/s-adm/.scripts/icon/battery-low-symbolic.svg \
				"СОСТОЯНИЕ БАТАРЕИ"  "Система работает при низком заряде батареи. Осталось ${BATT_PERCENT} % ";
				# будем напоминать не так часто, добавим паузу
				sleep 180;
			fi


	else
		# если заряжается и дошло до 99% (больше обычно не поднимается) сообщим о полном заряде
		if [ "98" -le $BATT_PERCENT ];
			then

				notify-send -u normal -t 5000 -i \
				/home/s-adm/.scripts/icon/battery-full-charging-symbolic.svg \
				"СОСТОЯНИЕ БАТАРЕИ"  "Батарея полностью заряжена. Для увеличения срока службы батарею рекомендуется отключить от зарядного устройства";
				# будем напоминать каждые 15 минут пока не выключат зарядку
				SLEEP_INTERVAL=450;
				sleep $SLEEP_INTERVAL
		fi
#	для отладки
#	echo "Батарея " $BATT_STATUS
    fi

# дополнительно проверим обновления и запишем в промежуточный файл
# подготовка файла
cat /dev/null > /home/s-adm/.scripts/pactmp
pac=$(checkupdates | wc -l)

check=$((pac))
if [[ "$check" != "0" ]]
then
    echo "$pac  pkg" >> /home/s-adm/.scripts/pactmp # пишем информацию в файл для вывода в скрипт xmobar
else
    cat /dev/null > /home/s-adm/.scripts/pactmp # очищаем файл
fi

# дополнительно проверим погоду и запишем в промежуточный файл
# подготовка файла
cat /dev/null > /home/s-adm/.scripts/weatmp
# пишем текст погоды в файл для вывода в скрипт xmobar
#Search for your city at http://www.accuweather.com and replace the URL in the following script with the URL for your city:
URL='http://www.accuweather.com/ru/ru/surgut/288459/current-weather/288459'
wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°", $13}'| head -1 | sed 's/,  text:"//g' | rev | cut -c 5- | rev | sed 's/.*/\L&/' | sed 's/ясно//g' | sed 's/солнечно//g' | sed 's/слабый туман//g' | sed 's/слабый снег и туман/ /g' | sed 's/слабый снегопад//g' | sed 's/небольшой снег//g' | sed 's/снег//g' | sed 's/значительная облачность//g' | sed 's/облачно с прояснениями//g' | sed 's/малооблачно//g' | sed 's/облачно//g' >> /home/s-adm/.scripts/weatmp
#-иконки                  

 	sleep $SLEEP_INTERVAL

done
