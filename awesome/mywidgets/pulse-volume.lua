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

local volume_widget = {}
for s = 1, screen.count() do
    local layout = wibox.layout.margin()
    layout:set_margins(5)
    local bar = awful.widget.progressbar()
    layout:set_widget(bar)
    bar:set_width(10)
    bar:set_height(20)
    bar:set_vertical(true)
    bar:set_color("#24232300")
	bar:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 20 }, stops = { { 0, "#071A3FFF" }, { 1, "#2266FFFF" } }})
    vicious.register(bar, function()
        local proc = io.popen("pamixer --get-volume")
        local vol = proc:read()
        proc:close()

        return vol
    end, 3)

    volume_widget[s] = wibox.layout.fixed.horizontal()
    volume_widget[s]:add(volume_text)
    volume_widget[s]:add(layout)
    volume_widget[s]:add(sectionend)
end

return volume_widget
