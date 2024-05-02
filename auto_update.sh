#!/bin/bash

# Automatically deletes all configs in this directory and replaces them with
# the most current configuration files.

rm .bashrc
rm .taskrc
rm oh_my_bash_powerline_theme_custom
rm -r alacritty
rm -r awesome
rm -r picom
rm -r polybar
rm -r rofi
rm -r nvim 
rm -r tmux 
rm tlp/tlp.conf

cp /home/cyz/.bashrc .
cp /home/cyz/.taskrc .
cp /home/cyz/.oh-my-bash/themes/powerline/powerline.theme.sh .
mv powerline.theme.sh oh_my_bash_powerline_theme_custom
cp -r /home/cyz/.config/alacritty .
cp -r /home/cyz/.config/awesome .
cp -r /home/cyz/.config/picom .
cp -r /home/cyz/.config/polybar .
cp -r /home/cyz/.config/rofi .
cp -r /home/cyz/.config/nvim .
mkdir tmux
cp -r /home/cyz/.config/tmux/tmux.conf tmux
sudo less /etc/tlp.conf >> tlp/tlp.conf
sudo less /etc/tlp.d/00-template.conf >> tlp/tlp.d/00-template.conf
