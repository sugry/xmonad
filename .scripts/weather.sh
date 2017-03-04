#!/bin/sh

#Search for your city at http://www.accuweather.com and replace the URL in the following script with the URL for your city:

URL='http://www.accuweather.com/ru/ru/surgut/288459/current-weather/288459'
#URL='http://www.accuweather.com/ru/ru/surgut/288459/weather-forecast/288459?lang=ru'

# для отображения иконок нужен шрифт ttf-font-awesome (AUR)
#получим из стоки 1 столбец 10, добавим к нему "°" и столбец 13 | -12° ,  text:"Слабый снегопад"}); | уберем из середины хлам | реверс | срежем 5 первых | реверс назад | в нижний регистр | замена фраз на иконки
wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°", $13}'| head -1 | sed 's/,  text:"//g' | rev | cut -c 5- | rev | sed 's/.*/\L&/' | sed 's/ясно//g' | sed 's/солнечно//g' | sed 's/слабый туман//g' | sed 's/слабый снег и туман/ /g' | sed 's/слабый снегопад//g' | sed 's/небольшой снег//g' | sed 's/снег//g' | sed 's/значительная облачность//g' | sed 's/облачно с прояснениями//g' | sed 's/малооблачно//g' | sed 's/облачно//g' | sed 's/метель//g'
#-12° слабый снегопад                  
# пишем текст погоды в файл для вывода в notify-send по клику на модуле

cat /dev/null > /home/s-adm/.scripts/weatmp
wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°", $13}'| head -1 | sed 's/,  text:"//g' | rev | cut -c 5- | rev | sed 's/.*/\L&/' | sed 's/-/минус /g' >> /home/s-adm/.scripts/weatmp
