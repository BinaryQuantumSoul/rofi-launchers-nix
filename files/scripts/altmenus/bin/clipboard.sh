#!/usr/bin/env bash

## Author  : QuantumSoul
## Github  : @BinaryQuantumSoul
#
## Applets : Clipboard manager

cliphist list | \
rofi -dmenu \
     -p "Clipboard history" \
     -theme-str 'window {width: 50%;} listview {columns: 1;}'\
     -theme-str "$ROFI_LAUNCH_THEME_COLOR_STR" -theme-str "$ROFI_LAUNCH_THEME_FONT_STR" \
     -theme "$ROFI_LAUNCH_THEME_MAIN" \
| cliphist decode | wl-copy