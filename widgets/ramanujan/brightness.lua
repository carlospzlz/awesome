local wibox = require("wibox")
local watch = require("awful.widget.watch")

-- Create the text widget
local brightness_text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local brightness_widget = wibox.widget.background()
brightness_widget:set_widget(brightness_text)

-- Monitor brightness
watch('fish -c "cat /sys/class/backlight/acpi_video0/brightness"', 10,
      function(widget, stdout, stderr, exitreason, exitcode)
	      local brightness = stdout:gsub("%s+", "")
          local text = string.format(" %s* ", brightness)
	      brightness_text:set_text(text)
	  end,
	  brightness_widget
)

return brightness_widget
