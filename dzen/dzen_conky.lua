conky.config = {
  out_to_x = false,
  out_to_console = true,
  short_units = true,
  update_interval = 1
};


local function getShortHostname()
    local f = io.popen ("/bin/hostname -s")
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
    return hostname

end

local cpuIcon='/home/trevis/dzen/icons/cpu.xpm'
local cpuDisplay='^i(' .. cpuIcon ..')${cpu cpu0}% '

local memIcon='/home/trevis/dzen/icons/mem.xpm'
local memDisplay='^i(' .. memIcon .. ')${memperc}%'

local cpuAndMem = [[ ]] .. cpuDisplay .. memDisplay

local batteryIcon='/home/trevis/dzen/icons/batt.xpm'
local batteryDisplay='^i(' .. batteryIcon .. ') ${battery_percent}%'
local batteryClick='^ca(1,~/dotfiles/dzen/scripts/batt_popup.sh)' .. batteryDisplay .. ' ^ca()'

local freebsdBatteryDisplay='^i(' .. batteryIcon .. ') ${exec ~/dzen/scripts/freebsd_batt.sh}'
local freebsdBatteryClick='^ca(1,~/dotfiles/dzen/scripts/batt_popup.sh)' .. freebsdBatteryDisplay .. ' ^ca()'

local calendar='^ca(1,~/dzen/scripts/cal_popup.sh) ${time %a %d %b %T} ^ca()'

local middleSection

if getShortHostname() == 'magmadragoon' then

   local devuanUpdatesIcon='/home/trevis/dzen/icons/devuan50.xpm'
   local devuanUpdatesDisplay='^i(' .. devuanUpdatesIcon .. ') ${exec ~/dzen/scripts/apt_updates_num.sh}'
   local devuanUpdatesClick=' ^ca(1,~/dzen/scripts/apt_updates_popup.sh)' .. devuanUpdatesDisplay .. ' ^ca()'

   middleSection = devuanUpdatesClick
else
   if getShortHostname() == 'zero' then

      local freebsdPkgUpdatesIcon='/home/trevis/dzen/icons/freebsd50.xpm'
      local freebsdPkgUpdatesDisplay='^i(' .. freebsdPkgUpdatesIcon .. ') ${exec ~/dzen/scripts/pkg_updates_num.sh}'
      local freebsdPkgUpdatesClick=' ^ca(1,~/dzen/scripts/pkg_updates_popup.sh)' .. freebsdPkgUpdatesDisplay .. ' ^ca()'

      middleSection = freebsdPkgUpdatesClick .. freebsdBatteryClick
   else
      middleSection = [[ ]]
   end
end

if getShortHostname() ~= 'magmadragoon' then
   conky.text = cpuAndMem .. middleSection .. calendar;
else
   conky.text = cpuAndMem .. middleSection .. batteryClick .. calendar;
end
