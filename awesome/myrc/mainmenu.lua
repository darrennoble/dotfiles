local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop_utils = require("freedesktop.utils")
local freedesktop_menu = require("freedesktop.menu")
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

-- Reserved.
function init(enviroment)
	env = enviroment
end

local terminal = (os.getenv("TERMINAL") or 'terminator') .. " "
local man = (env.man or terminal .. " -e man") .. " "
local editor = "gvim "
local run = (env.run or "gmrun")

freedesktop_utils.terminal = terminal
--freedesktop_utils.icon_theme = beautiful.icon_theme
--freedesktop_utils.icon_sizes = {beautiful.icon_theme_size}

function get_favorites()
	local favorites_menu = {
		{ "        -- Terminals --", nil, nil}, --separator
--		{ "Terminal", terminal, freedesktop_utils.lookup_icon({icon = 'utilities-terminal'}) },
--		{ "Terminal", "Terminal", freedesktop_utils.lookup_icon({icon = 'terminal'}) },
		{ "Terminator", "terminator", freedesktop_utils.lookup_icon({icon = 'terminator'}) },
--		{ "Konsole", "konsole", freedesktop_utils.lookup_icon({icon = 'utilities-terminal'}) },
		{ "        -- Browsers --", nil, nil}, --separator
--		{ "Chromium", "chromium", freedesktop_utils.lookup_icon({icon = 'chromium'}) },
		{ "Chrome", "google-chrome-beta", freedesktop_utils.lookup_icon({icon = 'google-chrome-beta'}) },
		{ "Firefox", "firefox", freedesktop_utils.lookup_icon({icon = 'firefox'}) },
		{ "        -- Development --", nil, nil}, --separator
		{ "IntelliJ IDEA", "idea.sh", freedesktop_utils.lookup_icon({icon = 'idea'}) },
--		{ "PCManFM", "pcmanfm", freedesktop_utils.lookup_icon({icon = 'system-file-manager'}) },
		{ "Thunar", "thunar", freedesktop_utils.lookup_icon({icon = 'Thunar'}) },
		{ "        -- Chat --", nil, nil}, --separator
		{ "Pidgin", "pidgin", freedesktop_utils.lookup_icon({icon = 'pidgin'}) },
		{ "HipChat", "hipchat", freedesktop_utils.lookup_icon({icon = 'hipchat'}) },
		{ "        -- Media --", nil, nil}, --separator
		{ "SMplayer", "smplayer", freedesktop_utils.lookup_icon({icon = 'smplayer'}) },
		{ "kmix", "kmix", freedesktop_utils.lookup_icon({icon = 'kmix'}) },
		{ "pavucontrol", "pavucontrol", freedesktop_utils.lookup_icon({icon = 'multimedia-volume-control'}) },
		{ "Pulseaudio Equalizer", "pulseaudio-equalizer-gtk", freedesktop_utils.lookup_icon({icon = 'view-media-equalizer'}) },
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
		{ "Manual", man .. "awesome", freedesktop_utils.lookup_icon({ icon = 'help-contents' }) },
		{ "Edit config", editor .. awful.util.getdir("config") .. "/awesome.lua", freedesktop_utils.lookup_icon({ icon = 'package_settings' }) },
		{ "Edit theme", editor .. awful.util.getdir("config") .. "/theme.lua" , freedesktop_utils.lookup_icon({ icon = 'package_settings' }) },
		{"", nil, nil}, --separator
		{ "Restart", awesome.restart, freedesktop_utils.lookup_icon({ icon = 'system-reboot' }) },
		{ "Quit", awesome.quit, freedesktop_utils.lookup_icon({ icon = 'system-log-out' }) },
	}

	local favorites_menu = get_favorites()

	local myshutdownmenu = {
		{"Shutdown", "sudo halt", freedesktop_utils.lookup_icon({icon = 'system-shutdown'}) },
		{"Restart", "sudo reboot", freedesktop_utils.lookup_icon({icon = 'system-reboot'}) },
		{"Logout", awesome.quit, freedesktop_utils.lookup_icon({icon = 'system-log-out'}) },
	}

	local mymainmenu_items_head = {
		{ "Favorites", favorites_menu, freedesktop_utils.lookup_icon({icon = 'bookmarks'})},
		{"", nil, nil} --separator
	}

	local mymainmenu_items_tail = {
		{ "", nil, nil}, --separator
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		{ "", nil, nil}, --separator
		{ "Shutdown", myshutdownmenu, freedesktop_utils.lookup_icon({icon = 'system-shutdown'}) }
	}

	local mymainmenu_items = {}
	for _, item in ipairs(mymainmenu_items_head) do table.insert(mymainmenu_items, item) end
	for _, item in ipairs(freedesktop_menu.new()) do table.insert(mymainmenu_items, item) end
	for _, item in ipairs(mymainmenu_items_tail) do table.insert(mymainmenu_items, item) end

	return awful.menu({ items = mymainmenu_items })
end


function show_at(menu, kg, menu_coords)
	local old_coords = mouse.coords()
	local menu_coords = menu_coords or {x=0, y=0}
	mouse.coords(menu_coords)
	awful.menu.show(menu, kg)
	mouse.coords(old_coords)
end
