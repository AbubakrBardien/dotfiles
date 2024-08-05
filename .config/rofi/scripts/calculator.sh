#!/bin/bash
rofi -show calc -modi calc -no-show-match -no-sort -terse -no-history -lines 0 -calc-command "echo -n '{result}' | xclip" -theme ~/.config/rofi/configs/rofi_calc.rasi