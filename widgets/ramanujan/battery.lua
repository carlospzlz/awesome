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
local command = 'fish -c ' ..
'"cat /sys/class/power_supply/BAT0/capacity ' ..
     '/sys/class/power_supply/BAT0/status"'
watch(command, 10,
      function(_, stdout, stderr, exitreason, exitcode)
	      local lines = {}
		  for line in stdout:gmatch("[^\n]+") do
		      table.insert(lines, line)
		  end
	      local capacity = lines[1]
	      local status = lines[2]
          local text = string.format(" %s%% ", capacity)
	      battery_text:set_text(text)
		  if (status == "Charging") then
		      battery_widget:set_fg("#00FF00")
		  elseif (tonumber(capacity) < 10) then
		      battery_widget:set_fg("#FF0000")
			  os.execute("beep -f 1000 -l 50 -r 2")
		  else
		      battery_widget:set_fg("#AAAAAA")
		  end
	  end,
	  battery_widget
)

return battery_widget
