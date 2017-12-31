#!/bin/bash
#pacman config
sudo rm /etc/pacman.conf
sudo ln -s $HOME/.dotfiles/pacman.conf /etc/pacman.conf
sudo pacman -Syu
sudo pacman -S yaourt
#install enviroment
sudo pacman -S xorg xorg-xinit xorg-server xmonad xmonad-contrib xmobar dzen2 dmenu mesa mesa-demos libxss trayer xdg-user-dirs pulseaudio pulseaudio-alsa pacvucontrol pamixer feh ranger libcaca highlight atool w3m lynx poppler transmission-cli mediainfo perl-image-exiftool firefox numlockx
ranger --copy-config=all
rm $HOME/.config/ranger/rc.conf
ln -s $HOME/.dotfiles/rc.conf $HOME/.config/ranger/rc.conf
xdg-user-dirs-update
yaourt -S notify-osd-customizable notifyconf termite-ranger-fix-git systemd-numlockontty
systemctl enable numLockOnTty
mkdir -p /etc/systemd/system/getty@tty1.service.d/
sudo ln -s ~/.dotfiles/autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo pacman -S ttf-liberation ttf-bitstream-vera ttf-dejavu ttf-droid ttf-freefont artwiz-fonts
ln -s $HOME/.dotfiles/notify-osd $HOME/.notify-osd
mkdir -p $HOME/.config/compton
ln -s $HOME/.dotfiles/compton.conf $HOME/.config/compton/compton.conf
ln -s $HOME/.dotfiles/xmonad $HOME/.xmonad
ln -s $HOME/.dotfiles/bin $HOME/.bin
ln -s $HOME/.dotfiles/xinitrc $HOME/.xinitrc
ln -s $HOME/.dotfiles/Xdefaults $HOME/.Xdefaults
sudo pacman -S zsh
chsh -s /bin/zsh
curl -L http://install.ohmyz.sh | sh
ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/lambda-mod.zsh-theme
ln -s $HOME/.dotfiles/stalonetrayrc $HOME/.stalonetrayrc
#apps config
# termite vim, npm, ...
sudo pacman -S ctags python-pygments npm
mkdir -p $HOME/.config/termite
ln -s $HOME/.dotfiles/termite/config $HOME/.config/termite/config
mkdir $HOME/.node_modules
mkdir .npm-modules
ln -s $HOME/.dotfiles/npmrc $HOME/.npmrc
echo "##### Space Vim Pre-Installation ######"
sudo pacman -S vim neovim
curl -sLf https://spacevim.org/install.sh | bash
echo "remember install nerdfonts"
mkdir SpaceVim.d
ln -s $HOME/.dotfiles/init.vim $HOME/.SpaceVim.d/init.vim
npm -g install remark
npm -g install remark-cli
npm -g install remark-stringify
echo "***DONE***"
