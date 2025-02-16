#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


read -p "Enter the desired resolution (e.g., 1920x1080): " resolution
read -p "Enter the refresh rate (e.g., 60): " refresh_rate


echo -e "${BLUE}Available display connections:${NC}"
xrandr --listactivemonitors


read -p "Enter the display connection (e.g., HDMI-1, eDP-1): " display_connection


set_resolution() {
    if xrandr --output $display_connection --mode $resolution --rate $refresh_rate; then
        echo -e "${GREEN}Resolution set to $resolution at $refresh_rate Hz on $display_connection.${NC}"
    else
        echo -e "${RED}Failed to set resolution. Please check the input values and try again.${NC}"
    fi
}


if ! xrandr | grep -q "$resolution"; then
    echo -e "${BLUE}Adding new resolution $resolution...${NC}"
    cvt $(echo $resolution | sed 's/x/ /') $refresh_rate
    newmode=$(cvt $(echo $resolution | sed 's/x/ /') $refresh_rate | grep Modeline | sed 's/Modeline //;s/"//g')
    xrandr --newmode $newmode
    xrandr --addmode $display_connection $resolution
fi


set_resolution