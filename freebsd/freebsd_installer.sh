
# Change rc files around to start daemons at boot
rc() {
  echo 'hald_enable="YES"
dbus_enable="YES"
slim_enable="YES"
wlans_iwn0="wlan0"
ifconfig_wlan0="WPA DHCP"' >> /etc/rc.conf;
}

case $NAME in
    "charmy")
        # Charmy gets the other default softs/dotfiles
        pkg install `cat freebsd_pkgs.txt`;

esac
