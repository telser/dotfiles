conky.config = {
  out_to_x = false,
  out_to_console = true,
  short_units = true,
  update_interval = 1
};


function getShortHostname()
    local f = io.popen ("/bin/hostname -s")
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
    return hostname

end

cpuIcon='/home/trevis/dzen/icons/cpu.xpm'
cpuDisplay='^i(' .. cpuIcon ..')${cpu cpu0}% '

memIcon='/home/trevis/dzen/icons/mem.xpm'
memDisplay='^i(' .. memIcon .. ')${memperc}%'

updatesIcon='/home/trevis/dzen/icons/pkgsrc50.xpm'
updatesDisplay='^i(' .. updatesIcon .. ') ${exec ~/dzen/scripts/pkgsrc_updates_num.sh}'
updatesClick='  ^ca(1,~/dzen/scripts/pkgsrc_updates_popup.sh)' .. updatesDisplay .. '^ca() '

devuanUpdatesIcon='/home/trevis/dzen/icons/devuan50.xpm'
devuanUpdatesDisplay='^i(' .. devuanUpdatesIcon .. ') ${exec ~/dzen/scripts/apt_updates_num.sh}'
devuanUpdatesClick=' ^ca(1,~/dzen/scripts/apt_updates_popup.sh)' .. devuanUpdatesDisplay .. ' ^ca()'

freebsdPkgUpdatesIcon='/home/trevis/dzen/icons/freebsd50.xpm'
freebsdPkgUpdatesDisplay='^i(' .. freebsdPkgUpdatesIcon .. ') ${exec ~/dzen/scripts/pkg_updates_num.sh}'
freebsdPkgUpdatesClick=' ^ca(1,~/dzen/scripts/pkg_updates_popup.sh)' .. freebsdPkgUpdatesDisplay .. ' ^ca()'

freebsdBaseUpdatesIcon='/home/trevis/dzen/icons/freebsdWhite50.xpm'
freebsdBaseUpdatesDisplay='^i(' .. freebsdBaseUpdatesIcon .. ') ${exec ~/dzen/scripts/freebsd_updates_num.sh}'
freebsdBaseUpdatesClick=' ^ca(1,~/dzen/scripts/freebsd_updates_popup.sh)' .. freebsdBaseUpdatesDisplay .. ' ^ca()'

cpuAndMem = [[ ]] .. cpuDisplay .. memDisplay

batteryIcon='/home/trevis/dzen/icons/batt.xpm'
batteryDisplay='^i(' .. batteryIcon .. ') ${battery_percent}%'
batteryClick='^ca(1,~/dotfiles/dzen/scripts/batt_popup.sh)' .. batteryDisplay .. ' ^ca()'

freebsdBatteryDisplay='^i(' .. batteryIcon .. ') ${exec ~/dzen/scripts/freebsd_batt.sh}'

calendar='^ca(1,~/dotfiles/dzen/scripts/cal_popup.sh) ${time %a %d %b %T} ^ca()'

if getShortHostname() == 'magmadragoon' then
   middleSection = devuanUpdatesClick
else
   if getShortHostname() == 'zero' then
      middleSection = freebsdPkgUpdatesClick .. freebsdBaseUpdatesClick .. freebsdBatteryDisplay
   else
      middleSection = [[ ]]
   end
end

if getShortHostname() ~= 'magmadragoon' then
   conky.text = cpuAndMem .. middleSection .. calendar;
else
   conky.text = cpuAndMem .. middleSection .. batteryClick .. calendar;
end
