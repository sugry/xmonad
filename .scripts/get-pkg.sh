#!/bin/sh

SLEEP_INTERVAL=60
while :; do

    TESTHOST="8.8.8.8"
    ping -c 1 -w 5 $TESTHOST &>/dev/null

    if [[ $? -ne 0 ]]
        then SLEEP_INTERVAL=3600
        pac=$(checkupdates | wc -l)

        check=$((pac))
        if [[ "$check" != "0" ]]
            then
            echo "$pac  pkg" >> /tmp/.getpkg-pipe
        else echo >> /tmp/.getpkg-pipe
        fi
    else SLEEP_INTERVAL=60
    fi
    
    sleep $SLEEP_INTERVAL
done
