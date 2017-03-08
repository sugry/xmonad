#!/bin/sh
urxvtc -name update -e yaourt -Syua &&
while `pgrep yaourt >/dev/null`
do
    sleep 1
done

#TESTHOST="8.8.8.8"
#ping -c 1 -w 5 $TESTHOST &>/dev/null

#if [[ $? -ne 0 ]]
#    then
    pac=$(checkupdates | wc -l)
    check=$((pac))
    if [[ "$check" != "0" ]]
        then
        echo "$pac  pkg" >> /tmp/.getpkg-pipe
    else echo >> /tmp/.getpkg-pipe
    fi
#else echo >> /tmp/.getpkg-pipe
#fi

exit 0
