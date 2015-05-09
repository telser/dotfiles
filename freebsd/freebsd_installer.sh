flash() {
    kldload linux;
    pkg install linux_base-f10;
    cd /usr/ports/www/nspluginwrapper;
    make install distclean;
    cd /usr/ports/www/linux-f10-flashplugin11;
    DISABLE_VULNERABILITIES=yes make install distclean;
    mkdir /usr/local/lib/browser_plugins;
    ln -s /usr/local/lib/browser_plugins/linux-f10-flashplugin/libflashplayer.so \
        /usr/local/lib/browser_plugins/;
    su -u trevis nspluginwrapper -v -a -i
}

wine() {
    cd /usr/ports/emulators/i386-wine;
    make install distclean;
}

# Change rc files around to start daemons at boot
rc() {
    echo 'hald_enable="YES"
dbus_enable="YES"
slim_enable="YES"
linux_enable="YES"
wlans_iwn0="wlan0"
ifconfig_wlan0="WPA DHCP"' >> /etc/rc.conf;
}

tails_rc() {
    echo 'hald_enable="YES"
dbus_enable="YES"
slim_enable="YES"
linux_enable="YES"
wlans_iwn0="wlan0"
ifconfig_wlan0="WPA DHCP"' >> /etc/rc.conf;
}

case $NAME in
    "charmy")
        # Charmy gets the other default softs/dotfiles
        pkg install `cat freebsd_pkgs.txt`;
        rc
        flash
        ;;
    "tails")
        pkg install `cat tails_pkgs.txt`;
        tails_rc;
        ;;
esac
