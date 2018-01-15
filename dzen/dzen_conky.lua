conky.config = {
  out_to_x = false,
  out_to_console = true,
  short_units = true,
  update_interval = 1
}

cpuIcon='/home/trevis/dzen/icons/cpu.xpm'
cpuDisplay='^i(' .. cpuIcon ..')${cpu cpu0}% '

memIcon='/home/trevis/dzen/icons/mem.xbm'
memDisplay='^i(' .. memIcon .. ')${memperc}%'

updatesIcon='/home/trevis/dzen/icons/debian.xpm'
updatesDisplay='^i(' .. updatesIcon .. ')${exec ~/dzen/scripts/apt_updates_num.sh}'
updatesClick='  ^ca(1,~/dzen/scripts/apt_updates_popup.sh)' .. updatesDisplay .. '^ca() '

conky.text = [[\
]] .. cpuDisplay .. memDisplay .. updatesClick .. [[\
^ca(1,~/dotfiles/dzen/scripts/batt_popup.sh) ^fg(\#556c85)^i(/home/trevis/dzen/icons/batt.xbm) ^fg()${battery_percent}%   ^ca()\
${exec ~/dotfiles/dzen/scripts/show_current_desktop.sh} \
^ca(1,~/dotfiles/dzen/scripts/cal_popup.sh) ${time %T} ^ca()\
]]                                                                                    
