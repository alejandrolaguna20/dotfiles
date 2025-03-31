#!/bin/bash

PROFILE_NAME="everforest"

EXISTING_PROFILES=$(gsettings get org.gnome.Terminal.ProfilesList list)
# generate new UUID
NEW_UUID=$(uuidgen)

if [[ $EXISTING_PROFILES != *"$NEW_UUID"* ]]; then
    gsettings set org.gnome.Terminal.ProfilesList list "$(echo $EXISTING_PROFILES | sed "s/]$/, '$NEW_UUID']/")"
    gsettings set org.gnome.Terminal.ProfilesList default "$NEW_UUID"
fi

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/visible-name "'$PROFILE_NAME'"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/font "'Monolisa Medium 10'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/use-system-font "false"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/audible-bell "false"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/background-color "'#000000'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/foreground-color "'#d3c6aa'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-background-color "'#000000'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-foreground-color "'#2d353b'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/use-theme-colors "false"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/palette "[
'#2d353b', '#e67e80', '#a7c080', '#dbbc7f', '#7fbbb3', '#d699b6', '#83c092', '#d3c6aa',
'#475258', '#e67e80', '#a7c080', '#dbbc7f', '#7fbbb3', '#d699b6', '#83c092', '#d3c6aa'
]"

echo "GNOME Terminal profile '$PROFILE_NAME' created and applied! Reset your terminal, just in case :)"

