packages() {
    pkgs='"zsh" "git" "xorg" "slim" "hs-xmonad" "hs-xmonad-contrib" "tint2" "conky"
"chromium" "firefox" "konsole" "nitrogen" "lxrandr" "clipit"
"password-store" "htop" "curl" "mumble"'
    for i in $pkgs; do
        sudo pkg install "$i"
    done
}

fstab() {
    echo 'fdesc /dev/fd fdescfs rw 0 0' >> /etc/fstab;
}

rc() {
    echo 'hald_enable="YES"
dbus_enable="YES"
slim_enable="YES"' >> /etc/rc.conf;
}

dotfiles() {
    git clone https://gitlab.com/telser/dotfiles.git;
    for reg_file in "$HOME/dotfiles/"/* "$HOME/dotfiles/."*
    do
        if [ -f "$reg_file" ]; then
            ln -s "$reg_file" "$HOME"
        fi
    done
}
