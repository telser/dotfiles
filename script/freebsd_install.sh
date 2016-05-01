#!/usr/bin/env sh
packages() {
    pkgs='zsh git xorg slim hs-xmonad hs-xmonad-contrib tint2 conky dmenu tmux
chromium firefox konsole nitrogen lxrandr clipit en-hunspell nathive
password-store htop curl mumble weechat urwfonts virtualbox-ose-additions'
    sudo pkg install $packages
}

fstab() {
    sudo echo 'fdesc /dev/fd fdescfs rw 0 0' >> /etc/fstab;
}

rc() {
    sudo echo 'hald_enable="YES"
dbus_enable="YES"
slim_enable="YES"
vboxguest_enable="YES"
vboxservice_enable="YES"' >> /etc/rc.conf;
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

packages;
fstab;
rc;
dotfiles;

# Place slim config and theme

sudo cp -r "$HOME/dotfiles/freebsd/theme/*" /usr/local/share/slim/themes/telser-freebsd

cd ~;
wget https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-otf.zip --no-check-certificate

sudo mkdir /usr/local/share/fonts/Hack
sudo unzip -d /usr/local/share/fonts/Hack ~/Hack-v2_020-otf.zip

mkdir ~/walls;
cd ~/walls;
wget https://www.dropbox.com/s/lq1zglh0s3suq5o/freebsd_wallpaper.png?dl=0 --no-check-certificate;
cd ~;
