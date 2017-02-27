local awful = require("awful")
local beautiful = require("beautiful")
local menubar_utils = require("menubar.utils")
local freedesktop = require("freedesktop")
local wibox = require("wibox")

local io = io
local table = table
local awesome = awesome
local ipairs = ipairs
local os = os
local string = string
local mouse = mouse

module("myrc.mainmenu")

local env = {}

terminal = 'xterm'

-- Reserved.
function init(enviroment)
	env = enviroment
end

local editor = "gvim "
local run = (env.run or "gmrun")

function man(cmd)
	return terminal .. ' -e "man' .. cmd .. '"'
end

function get_favorites()
	local favorites_menu = {
		{ "		-- Terminals --", nil, nil}, --separator
--		{ "Terminal", terminal, menubar_utils.lookup_icon('utilities-terminal') },
--		{ "Terminal", "Terminal", menubar_utils.lookup_icon('terminal') },
		{ "Terminology", "terminology", menubar_utils.lookup_icon('teminology') },
		{ "Terminator", "terminology", menubar_utils.lookup_icon('teminology') },
--		{ "Konsole", "konsole", menubar_utils.lookup_icon('utilities-terminal') },
		{ "		-- Browsers --", nil, nil}, --separator
--		{ "Chromium", "chromium", menubar_utils.lookup_icon('chromium') },
		{ "Chrome", "google-chrome-stable", menubar_utils.lookup_icon('google-chrome') },
		{ "Firefox", "firefox", menubar_utils.lookup_icon('firefox') },
		{ "		-- Development --", nil, nil}, --separator
		{ "IntelliJ IDEA", "idea.sh", menubar_utils.lookup_icon('idea') },
--		{ "PCManFM", "pcmanfm", menubar_utils.lookup_icon('system-file-manager') },
		{ "Thunar", "thunar", menubar_utils.lookup_icon('Thunar') },
		{ "		-- Chat --", nil, nil}, --separator
		{ "Slack", "slack", menubar_utils.lookup_icon('slack') },
		{ "Pidgin", "pidgin", menubar_utils.lookup_icon('pidgin') },
		{ "		-- Media --", nil, nil}, --separator
		{ "SMplayer", "smplayer", menubar_utils.lookup_icon('smplayer') },
		{ "kmix", "kmix", menubar_utils.lookup_icon('kmix') },
		{ "pavucontrol", "pavucontrol", menubar_utils.lookup_icon('multimedia-volume-control') },
		{ "Pulseaudio Equalizer", "pulseaudio-equalizer-gtk", menubar_utils.lookup_icon('view-media-equalizer') },
	}

	return favorites_menu
end

function build_favorites()
	return awful.menu({ items = get_favorites() })
end

-- Creates main menu
-- Note: Uses beautiful.icon_theme and beautiful.icon_theme_size
-- env - table with string constants - command line to different apps
function build()
	local myawesomemenu = {
		{ "Manual", man("awesome"), menubar_utils.lookup_icon('help-contents') },
		{ "Edit config", editor .. awful.util.getdir("config") .. "/awesome.lua", menubar_utils.lookup_icon('package_settings') },
		{ "Edit theme", editor .. awful.util.getdir("config") .. "/theme.lua" , menubar_utils.lookup_icon('package_settings') },
		{"", nil, nil}, --separator
		{ "Restart", awesome.restart, menubar_utils.lookup_icon('system-reboot') },
		{ "Quit", awesome.quit, menubar_utils.lookup_icon('system-log-out') },
	}

	local favorites_menu = get_favorites()

	local myshutdownmenu = {
		{"Shutdown", "sudo halt", menubar_utils.lookup_icon('system-shutdown') },
		{"Restart", "sudo reboot", menubar_utils.lookup_icon('system-reboot') },
		{"Logout", awesome.quit, menubar_utils.lookup_icon('system-log-out') },
	}

	local mymainmenu_items_head = {
		{ "Favorites", favorites_menu, menubar_utils.lookup_icon('favorites')},
		{"", nil, nil} --separator
	}

	local mymainmenu_items_tail = {
		{ "", nil, nil}, --separator
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		{ "", nil, nil}, --separator
		{ "Shutdown", myshutdownmenu, menubar_utils.lookup_icon('system-shutdown') }
	}

	return freedesktop.menu.build({
		before = mymainmenu_items_head,
		after = mymainmenu_items_tail,
	})
end


function show_at(menu, kg, menu_coords)
	local old_coords = mouse.coords()
	local menu_coords = menu_coords or {x=0, y=0}
	mouse.coords(menu_coords)
	awful.menu.show(menu, kg)
	mouse.coords(old_coords)
end
