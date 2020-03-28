local wibox = require("wibox")
local watch = require("awful.widget.watch")

-- Create the text widget
local battery_text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local battery_widget = wibox.widget.background()
battery_widget:set_widget(battery_text)

-- Monitor battery
watch('fish -c "string sub -s 25 -l 3 (acpi -b)"', 10,
      function(widget, stdout, stderr, exitreason, exitcode)
	      battery_text:set_text(stdout)
	  end,
	  battery_widget
)

return battery_widget
