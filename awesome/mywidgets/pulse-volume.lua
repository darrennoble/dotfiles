local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

beautiful.init(awful.util.getdir("config") .. "/theme/black-blue/theme.lua")

local volume_text = wibox.widget.textbox()
vicious.register(volume_text, function()
        local proc = io.popen("pamixer --get-volume")
        local vol = proc:read()
        proc:close()

        proc = io.popen("pamixer --get-mute")
        local mute = proc:read()

        local volStr = vol .. "%"

        if mute == "true" then volStr = "M" end

        return sectionstart_text .. sectionTitle('Vol') .. " " .. volStr

    end, 3)

function new()
    local layout = wibox.layout.margin()
    layout:set_margins(5)
    
    --local normal_color = gears.color.create_linear_pattern({ type = "linear", from = { 0, 0 }, to = { 20, 0 }, stops = { { 0, "#071A3FFF" }, { 1, "#2266FFFF" } }})
    --local boost_color = gears.color.create_linear_pattern({ type = "linear", from = { 0, 0 }, to = { 20, 0 }, stops = { { 0, "#440056FF" }, { 1, "#C200F4FF" } }})
    local normal_color = gears.color("#2266FFFF")
    local boost_color = gears.color("#C200F4FF")

    local bar = wibox.widget {
            max_value     = 100,
            value         = 50,
            widget        = wibox.widget.progressbar,
            color         = normal_color,
            border_width  = 1,
            border_color  = "#222222FF",
            background_color = "#000000AA",
        }

    local barContainer = wibox.widget {
        forced_height = 5,
        forced_width  = 10,
        direction     = 'east',
        layout        = wibox.container.rotate,
    }
    barContainer:set_children({bar})
    layout:set_widget(barContainer)

    function update()
        local proc = io.popen("pamixer --get-volume")
        local vol = proc:read()
        proc:close()

        vol = tonumber(vol)

        if vol > 100 then
            vol = vol - 100
            bar:set_color(boost_color)
        else
            bar:set_color(normal_color)
        end

        bar:set_value(vol)
    end

    local timer = gears.timer({timeout = 3})
    timer:connect_signal("timeout", update)
    timer:start()
    timer:emit_signal("timeout")


    volume_widget = wibox.layout.fixed.horizontal()
    volume_widget:add(volume_text)
    volume_widget:add(layout)
    volume_widget:add(sectionend)

    return volume_widget
end

return new
