#!/bin/sh

SLEEP_INTERVAL=600
while :; do
    # Search for your city at http://www.accuweather.com and replace the URL in the following script with the URL for your city:
    URL='http://www.accuweather.com/ru/ru/surgut/288459/current-weather/288459'
    wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°", $13}'| head -1 | sed 's/,  text:"//g' | rev | cut -c 5- | rev | sed 's/.*/\L&/' >> /home/s-adm/.scripts/weatmp
    sleep $SLEEP_INTERVAL
done
