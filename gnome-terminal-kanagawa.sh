#!/bin/bash

PROFILE_NAME="kanagawa"

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

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/background-color "'#121214'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/foreground-color "'#dcd7ba'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-background-color "'#dcd7ba'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/cursor-foreground-color "'#121214'"
dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/use-theme-colors "false"

dconf write /org/gnome/terminal/legacy/profiles:/:$NEW_UUID/palette "[
'#16161d', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#dcd7ba',
'#223249', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#d27e99'
]"

echo "GNOME Terminal profile '$PROFILE_NAME' created and applied! Reset your terminal, just in case :)"

