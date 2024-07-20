#!/bin/bash

set -eou pipefail

# # #
# Unsplash Wallpaper Randomizer
# Source: https://github.com/razobeckett/random-scripts
#
# About:
# This script downloads a random image from an Unsplash collection and sets it as the wallpaper.
# using the `feh` command.
#
# Requirements:
# - feh
# - jq
# - curl
#
# How to use:
# $ chmod +x wallpaperengie.sh
# $ wallpaperengie.sh <UNSPLASH_API_KEY> <COLLECTION_ID>
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

checkParams() {
	if [ "$#" -ne 2 ]; then
		echo -e "
This script downloads a random image from an Unsplash collection and sets it as the wallpaper.

Usage: $0 <UNSPLASH_API_KEY> <COLLECTION_ID>

Other Scripts: https://github.com/razobeckett/random-scripts
"
		exit 1
	fi
}

GetImage() {
	UNSPLASH_API_KEY="${1}"
	COLLECTION_ID="${2}"
	SAVE_PATH="/tmp/wallpaper-$(date +'%d.%m.%y')-${RANDOM}.jpg"
	COLLECTION_URL="https://api.unsplash.com/collections/${COLLECTION_ID}/photos"

	# Download a random image from the Unsplash collection
	if ! IMAGE_URL=$(curl -s "${COLLECTION_URL}" -H "Authorization: Client-ID ${UNSPLASH_API_KEY}" | jq -r '.[].urls.full' | shuf -n 1); then
		echo "Failed to download image from Unsplash. Please check your API key and collection ID."
		exit 1
	fi

	# Save the image to the /tmp directory
	curl -s -o "$SAVE_PATH" "$IMAGE_URL"
	echo "Image saved to $SAVE_PATH"

	# Set the downloaded image as the wallpaper
	feh --no-fehbg --bg-fill "$IMAGE_URL"
}

checkParams "${@}"
check_dependencies
GetImage "${1}" "${2}"
