#!/usr/bin/env bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

# extract the keybinding from hyprland.conf
mapfile -t BINDINGS < <(grep '^bind=' "$HYPR_CONF" | \
    sed -e 's/  */ /g' -e 's/bind=//g' -e 's/, /,/g' -e 's/ # /,/' | \
    awk -F, -v q="'" '{cmd=""; for(i=3;i<NF;i++) cmd=cmd $(i) " ";print "<b>"$1 " + " $2 "</b>  <i>" $NF ",</i><span color=" q "gray" q ">" cmd "</span>"}')

CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | \
rofi -dmenu \
    -i -markup-rows \
    -p "Hyprland Keybinds" \
    -theme-str 'window {width: 50%;} listview {columns: 1;}' \
    -theme-str "$ROFI_LAUNCH_THEME_COLOR_STR" -theme-str "$ROFI_LAUNCH_THEME_FONT_STR" \
    -theme "$ROFI_LAUNCH_THEME_MAIN")

# extract cmd from span <span color='gray'>cmd</span>
CMD=$(echo "$CHOICE" | sed -n 's/.*<span color='\''gray'\''>\(.*\)<\/span>.*/\1/p')

# execute it if first word is exec else use hyprctl dispatch
if [[ $CMD == exec* ]]; then
    eval "$CMD"
else
    hyprctl dispatch "$CMD"
fi