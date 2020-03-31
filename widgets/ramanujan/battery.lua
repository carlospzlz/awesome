local wibox = require("wibox")
local watch = require("awful.widget.watch")

-- Create the text widget
local battery_text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local battery_widget = wibox.widget.background()
battery_widget:set_widget(battery_text)

-- Monitor battery capacity
watch('fish -c "cat /sys/class/power_supply/BAT0/capacity"', 10,
      function(_, stdout, stderr, exitreason, exitcode)
	      local capacity = stdout:gsub("%s+", "")
          local text = string.format(" %s%% ", capacity)
	      battery_text:set_text(text)
		  if (tonumber(capacity) < 10) then
		      battery_widget:set_fg("#ff0000")
		  end
	  end,
	  battery_widget
)

-- Monitor battery status
watch('fish -c "cat /sys/class/power_supply/BAT0/status"', 10,
      function(_, stdout, stderr, exitreason, exitcode)
	      local status = stdout:gsub("%s+", "")
		  if (status == "Charging") then
		      battery_widget:set_fg("#00FF00")
		  else
		      battery_widget:set_fg("#AAAAAA")
		  end
	  end,
	  battery_widget
)

return battery_widget
