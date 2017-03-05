#!/bin/sh

SLEEP_INTERVAL=3600
while :; do
    cat /dev/null > /home/s-adm/.scripts/pkgtmp
    pac=$(checkupdates | wc -l)

    check=$((pac))
    if [[ "$check" != "0" ]]
    then
        echo "$pac  pkg" >> /home/s-adm/.scripts/pkgtmp
    fi
    sleep $SLEEP_INTERVAL
done
