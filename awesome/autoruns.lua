-- awful.util.spawn("killall trayer")
awful.util.spawn("xset +dpms")
awful.util.spawn("xset dpms 0 0 300")
awful.util.spawn("setxkbmap -model pc105 -layout us -option ctrl:swapcaps")
awful.util.spawn("xrandr --dpi 160")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once xcape")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once nm-applet")
--awful.util.spawn(os.getenv('HOME') .. "/bin/run_once kmix")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once clipit")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once pulseaudio -D")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once xscreensaver")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once udiskie")
--awful.util.spawn(os.getenv('HOME') .. "/bin/run_once cairo-compmgr")
awful.util.spawn(os.getenv('HOME') .. "/bin/run_once insync start")
awful.util.spawn("wmname LG3D")
awful.util.spawn("feh --bg-scale ~/.config/awesome/wallpaper.jpg")
-- awful.util.spawn("trayer --edge top --align right --widthtype pixels --width 100 --height 18 --SetDockType true --transparent true --alpha 102 --distance 0 --expand false --margin 20 --padding 0 --tint 0x2D2D2D")
awful.util.spawn("blueman-applet")