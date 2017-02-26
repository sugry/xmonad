#!/bin/sh

export JAVA_HOME=/usr/lib/jvm/java-default-runtime
export PATH=~/bin:$PATH
export PATH=~/bin:$PATH
export TERMINAL=lxterminal
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export _volume_pipe=/tmp/.volume-pipe
[[ -S $_volume_pipe ]] || mkfifo $_volume_pipe

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

setxkbmap -layout "us,ru"
setxkbmap -option "grp:caps_toggle,grp_led:caps"
numlockx &
perWindowLayoutD & # демон, который запоминает выбранную раскладку для каждого окна http://archlinux.org.ru/forum/topic/3124/
compton &
# отключаем тачпад во время набора с клавиатуры
syndaemon -i 2 -d &
# отключаем тачпад совсем
# нужно узнать id тачпада командой xinput list
#xinput disable 15
xrdb -merge ~/.Xresources &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 3 --transparent true --alpha 0 --tint 0x232323 --height 21 &
parcellite &
nm-applet &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
$HOME/.scripts/lowbatt_notify.sh &

#feh --bg-center /usr/share/backgrounds/003.jpg
#dropbox &
qterminal -d &

exec xmonad

