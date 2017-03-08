#!/bin/sh
if (pidof orage >/dev/null); then kill $(pidof orage)
else orage
fi
exit 0
