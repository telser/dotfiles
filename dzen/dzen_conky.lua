conky.config = {
  out_to_x = false,
  out_to_console = true,
  short_units = true,
  update_interval = 1
};

cpuIcon='/home/trevis/dzen/icons/cpu.xpm'
cpuDisplay='^i(' .. cpuIcon ..')${cpu cpu0}% '

memIcon='/home/trevis/dzen/icons/mem.xbm'
memDisplay='^i(' .. memIcon .. ')${memperc}%'

updatesIcon='/home/trevis/dzen/icons/pkgsrc50.xpm'
updatesDisplay='^i(' .. updatesIcon .. ') ${exec ~/dzen/scripts/pkgsrc_updates_num.sh}'
updatesClick='  ^ca(1,~/dzen/scripts/pkgsrc_updates_popup.sh)' .. updatesDisplay .. '^ca() '

voidupdatesIcon='/home/trevis/dzen/icons/void50.xpm'
voidupdatesDisplay='^i(' .. voidupdatesIcon .. ') ${exec ~/dzen/scripts/void_updates_num.sh}'
voidupdatesClick='  ^ca(1,~/dzen/scripts/void_updates_popup.sh)' .. voidupdatesDisplay .. '^ca()'

conky.text = [[\
]] .. cpuDisplay .. memDisplay .. updatesClick .. voidupdatesClick .. [[\
^ca(1,~/dotfiles/dzen/scripts/batt_popup.sh) ^fg(\#556c85)^i(/home/trevis/dzen/icons/batt.xbm) ^fg()${battery_percent}%  ^ca()\
^ca(1,~/dotfiles/dzen/scripts/cal_popup.sh) ${time %a %d %b %T} ^ca()\
]];
