#!/usr/bin/env bash

# # #
# If connected to a specific WiFi SSID
# Source: https://github.com/razobeckett/random-scripts
#
# About:
# This script checks if the device is connected to a specific WiFi SSID.
#
# Requirements:
# - nmcli
#
# How to use:
# $ chmod +x connected-to-wifi-ssid.sh
# $ ./connected-to-wifi-ssid.sh <target_ssid>
# # #

check_dependencies() {
	# Check if feh is installed
	if ! command -v nmcli &>/dev/null; then
		echo "nmcli is not installed. Please install it and try again."
		exit 1
	fi
}

if [ "$#" -ne 1 ]; then
	echo -e "
This script checks if the device is connected to a specific WiFi SSID.

Usage: $0 <target_ssid>

Other Scripts: https://github.com/razobeckett/random-scripts
"
	exit 1
fi
target_ssid="$1"

# Check if the required dependencies are installed
check_dependencies

# Get the current WiFi SSID using nmcli
current_ssid=$(nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d':' -f2)

# Check if connected to the target WiFi
if [ "$current_ssid" == "$target_ssid" ]; then
	echo "Connected to $target_ssid"
else
	echo "Not connected to $target_ssid"
	exit 1
fi


