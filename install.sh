#!/bin/bash

rm ~/.bashrc
rm -r ~/.config/alacritty
rm -r ~/.config/awesome
rm -r ~/.config/picom
rm -r ~/.config/polybar
rm -r ~/.config/rofi
rm -r ~/.config/tmux
rm ~/.oh-my-bash/themes/powerline/powerline.theme.sh

cp .bashrc ~
cp -r alacritty ~/.config
cp -r awesome ~/.config
cp -r picom ~/.config
cp -r polybar ~/.config
cp -r rofi ~/.config
cp -r tmux ~/.config
cp oh_my_bash_powerline_theme_custom ~/.oh-my-bash/themes/powerline/
mv ~/.oh-my-bash/themes/powerline/oh_my_bash_powerline_theme_custom ~/.oh-my-bash/themes/powerline/powerline.theme.sh
