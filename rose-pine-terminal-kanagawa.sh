#!/bin/bash

PROFILE_NAME="rose-pine"

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
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/foreground-color "'#e0def4'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-background-color "'#e0def4'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-foreground-color "'#000000'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/use-theme-colors "false"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/palette "[
'#191724', '#eb6f92', '#31748f', '#f6c177', '#9ccfd8', '#c4a7e7', '#ebbcba', '#e0def4',
'#6e6a86', '#eb6f92', '#31748f', '#f6c177', '#9ccfd8', '#c4a7e7', '#ebbcba', '#e0def4'
]"

echo "GNOME Terminal profile '$PROFILE_NAME' created and applied! Reset your terminal, just in case :)"

