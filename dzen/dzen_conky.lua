conky.config = {
  out_to_x = false,
  out_to_console = true,
  short_units = true,
  update_interval = 1
}

conky.text = [[\
^i(~/dzen/icons/cpu.xpm)${cpu cpu0}% ^i(~/dzen/icons/mem.xbm)${memperc}%\
^ca(1,~/dzen/scripts/batt_popup.sh) ^fg(\#556c85)^i(~/dzen/icons/mem.xbm) ^fg(\#828a8c)${battery_percent}%   ^ca()\
up:${upspeed}\
down:${downspeed}\
${exec ~/dzen/scripts/show_current_desktop.sh} \
^ca(1,~/dzen/scripts/cal_popup.sh) ${time %T} ^ca()\
]]                                                                                    
