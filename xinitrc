# screen powersave
xset +dpms
xset dpms 0 0 300

#swap left ctrl and caps lock
setxkbmap -model pc105 -layout us -option ctrl:swapcaps

#change dpi
xrandr --dpi 192

#start wm
exec $1
