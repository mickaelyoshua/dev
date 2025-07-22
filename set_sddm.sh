#!/bin/bash

# Necessary packages
yay -Sy sddm-astronaut-theme

# Set up files
sudo mkdir /etc/sddm.conf.d
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf.d/sddm.conf
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf

sudo cp ~/personal/wallpapers/space-blue.png /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/

# Select theme by editing metadata (/usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop)
# Just edit:
# ConfigFile=Themes/astronaut.conf
