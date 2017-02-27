local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/theme/black-blue/theme.lua")

-- CPU Status
local cputext = wibox.widget.textbox()
vicious.register(cputext, function()
		local cmd = "uptime | cut -d: -f5"
		local f = io.popen(cmd)
		local cpuLoad = f:read()
		local max = 0
		f:close()

		cmd = "cat /proc/cpuinfo | grep MHz | cut -d: -f2"
		f = io.popen(cmd)
		while true do
			local l = f:read()
			if l == nul then break end
			l = l + 0
			if l > max then max = l end
		end
		local str = " " .. string.format("%.1f", max / 1000) .. "GHz "
		f:close()

		return sectionstart_text .. sectionTitle('CPU') .. cpuLoad .. " " .. separator_text .. str .. separator_text
	end, 3)

function new() 
	-- Initialize widget
	local layout = wibox.layout.margin()
	layout:set_margins(5)
	local graph = awful.widget.graph()
	layout:set_widget(graph)
	-- Graph properties
	graph:set_width(50)
	graph:set_height(20)
	graph:set_background_color("#24232300")
	--cpuwidget[s]:set_color("#2266FF")
	graph:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 20 }, stops = { { 0, "#071A3FFF" }, { 1, "#2266FFFF" } }})
	--awful.widget.layout.margins[cpuwidget[s].widget] = 3
	-- Register widget
	vicious.register(graph, vicious.widgets.cpu, "$1")

	cpuwidget = wibox.layout.fixed.horizontal()
	cpuwidget:add(cputext)
	cpuwidget:add(layout)
	cpuwidget:add(sectionend)

    return cpuwidget
end

return new
