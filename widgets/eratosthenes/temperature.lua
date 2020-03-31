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
      function(_, stdout, stderr, exitreason, exitcode)
          local temp_str = stdout:gsub("%s+", "")
          local text = string.format(" %s°C ", temp_str)
          temperature_text:set_text(text)
          local temp_num = tonumber(temp_str)
          if (temp_num < 60) then
              temperature_widget:set_fg("#AAAAAA")
          elseif (temp_num < 70) then
              temperature_widget:set_fg("#FFA500")
          else
              temperature_widget:set_fg("#FF0000")
          end
      end,
      temperature_widget
)

return temperature_widget
