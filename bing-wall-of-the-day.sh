#!/usr/bin/env bash

# # #
# Bing Image Of The Day
# Source: https://github.com/razobeckett/random-scripts
#
# About:
# This script fetches the Bing Wallpaper of the Day and sets it as the wallpaper.
# The script uses `feh` to set the wallpaper.
#
# Requirements:
# - feh
# - jq
# - curl
#
# How to use:
# $ chmod +x walloftheday.sh
# $ ./walloftheday.sh
# # #

check_dependencies() {
	# Check if feh is installed
	if ! command -v feh &>/dev/null; then
		echo "feh is not installed. Please install it and try again."
		exit 1
	fi

	# Check if jq is installed
	if ! command -v jq &>/dev/null; then
		echo "jq is not installed. Please install it and try again."
		exit 1
	fi

	# Check if curl is installed
	if ! command -v curl &>/dev/null; then
		echo "curl is not installed. Please install it and try again."
		exit 1
	fi

}

# Function to set the Bing Wallpaper of the Day
set_wallpaper_of_the_day() {
	# Use `curl` to fetch the Bing Wallpaper of the Day image
	IMAGE_URL=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1" | jq -r '.images[0].url')
	WALLPAPER_URL="https://www.bing.com$IMAGE_URL"
	SAVE_PATH="/tmp/bing-wallpaper-$(date +'%d.%m.%y').jpg"
	curl -s -o "$SAVE_PATH" "$WALLPAPER_URL"
	echo "Saved the Bing Wallpaper of the Day to $SAVE_PATH"

	# Set the downloaded image as the wallpaper with a fade effect
	feh --no-fehbg --bg-fill "$WALLPAPER_URL"
}

# Check if the required dependencies are installed
check_dependencies

# Set wallpaper of the day at startup
if ping -q -c 1 -W 1 bing.com >/dev/null; then
	set_wallpaper_of_the_day
else
	echo "No internet connection. Can't fetch the Bing Wallpaper of the Day."
	echo "Other Scripts: https://github.com/razobeckett/random-scripts"
fi
