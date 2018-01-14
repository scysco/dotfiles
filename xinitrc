export PATH="${PATH}:~/.bin/exec"
export GUIVAR=value
/usr/lib/notify-osd-customizable/notify-osd &
compton -b --config ~/.config/compton/compton.conf
numlockx &
exec xmonad
