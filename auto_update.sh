#!/bin/bash

# Automatically deletes all configs in this directory and replaces them with
# the most current configuration files.

rm .bashrc
rm oh_my_bash_powerline_theme_custom
rm -r alacritty
rm -r awesome
rm -r picom
rm -r polybar
rm -r rofi


cp ~/.bashrc .
cp ~/.oh-my-bash/themes/powerline/powerline.theme.sh .
mv powerline.theme.sh oh_my_bash_powerline_theme_custom
cp -r ~/.config/alacritty .
cp -r ~/.config/awesome .
cp -r ~/.config/picom .
cp -r ~/.config/polybar .
cp -r ~/.config/rofi .

