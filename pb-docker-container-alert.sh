#!/usr/bin/env bash
set -euo pipefail

# # #
# Pushbullet Docker Container Down Alert
# Source: https://github.com/razobeckett/random-scripts
#
# About:
# This script checks if the specified Docker containers are running. If a container is not running,
# it sends a Pushbullet notification to alert the user.
#
# Requirements:
# - curl
# - Pushbullet account and access token
#
# Note:
# - scipt ment to run in the background
# - you can setup a cron job to run this script every hour
# - Docker container names must be specified in the `container_names` array
# - The script will check if the containers are running every hour
#
# How to use:
# $ chmod +x pb-docker-container-alert.sh
# $ container_names=("container1" "container2" "container3") ./pb-docker-container-alert.sh
# # #

check_dependencies() {
	# Check if feh is installed
	if ! command -v curl &>/dev/null; then
		echo "curl is not installed. Please install it and try again."
		exit 1
	fi

	if ! command -v docker &>/dev/null; then
		echo "You don't even have docker why are you running this script?"
		exit 1
	fi
}

if [ "$#" -ne 1 ]; then
	echo -e "
This script checks if the specified Docker containers are running. If a container is not running,
it sends a Pushbullet notification to alert the user.

Usage: $0 <pushbullet_access_token>

Other Scripts: https://github.com/razobeckett/random-scripts
"
	exit 1
fi
pushbullet_access_token="$1"

if [ -z "${container_names[*]}" ]; then
	echo "Error: Array 'container_names' is not set."
	exit 1
fi

# Loop through the container names and check if they are running
for container_name in "${container_names[@]}"; do
	#echo $container_name # testing
	if ! docker ps -f name="$container_name" --format "{{.Names}}" | grep -q "$container_name"; then
		echo "Container '$container_name' is not running!"
		# Send a Pushbullet notification
		current_time=$(date +"%I:%M %p")
		push_title="Docker Container Alert - $current_time"
		push_message="Container '$container_name' is not running."
		curl -u "$pushbullet_access_token": -d type="note" -d title="$push_title" -d body="$push_message" -d importance="high" https://api.pushbullet.com/v2/pushes
	else
		echo "[✓] All Alive || $(date +"%Y-%m-%d %I:%M %p")"
	fi
done
