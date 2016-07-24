-- colors
section_color = "#2266FF"
highlight_color = "#DDDDDD"

--sectionstart = widget({ type = "textbox" })
sectionstart_text = " <span color='" .. section_color .."'><b>[</b></span>"
sectionstart = wibox.widget.textbox(sectionstart_text)
--sectionstart.text = sectionstart_text

--sectionend = widget({ type = "textbox" })
sectionend_text = "<span color='" .. section_color .."'><b>]</b></span>"
sectionend = wibox.widget.textbox(sectionend_text)
--sectionend.text = sectionend_text

--separator = widget({ type = "textbox" })
separator_text = "<span color='" .. section_color .."'><b>|</b></span>"
separator = wibox.widget.textbox(separator_text)
--separator.text = separator_text

function sectionTitle(str)
	return "<span color='" .. highlight_color .."'><b>" .. str .. ":</b></span>"
end

return {
	sectionstart = sectionstart;
	sectionend = sectionend;
	separator = separator;
	sectionTitle = sectionTitle;
}
