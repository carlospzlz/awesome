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
watch('fish -c "string sub -s 18 -l 2 (sensors | grep Tdie)"', 5,
      function(widget, stdout, stderr, exitreason, exitcode)
	      local temp = stdout:gsub("%s+", "")
          local text = string.format(" %s°C ", temp)
	      temperature_text:set_text(text)
	  end,
	  temperature_widget
)

return temperature_widget
