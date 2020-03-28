local wibox = require("wibox")
local watch = require("awful.widget.watch")

-- Create the text widget
local temperature_text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local temperature_widget = wibox.widget.background()
temperature_widget:set_widget(temperature_text)

-- Monitor temperature
watch('fish -c "string sub -s 17 -l 8 (sensors | grep Package)"', 10,
      function(widget, stdout, stderr, exitreason, exitcode)
	      temperature_text:set_text(stdout)
	  end,
	  temperature_widget
)

return temperature_widget
