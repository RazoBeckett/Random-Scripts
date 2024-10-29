#!/bin/bash

# # #
# Daily Dev Tips
# Source: https://github.com/razobeckett/random-scripts
#
# About:
# This script provides a random developer tip, joke, or quote along with the current date, time, and weather.
# A fun, quick boost to start your coding session on a positive note!
#
# Requirements:
# - curl (for fetching weather information)
#
# How to use:
# $ chmod +x daily-dev-tips.sh
# $ ./daily-dev-tips.sh [location]
# Example:
# $ ./daily-dev-tips.sh "San Francisco"
# # #

# Fetch a random development tip or joke
function fetch_dev_tip {
	tips=(
		"Keep your functions short and sweet. Aim for one purpose per function!"
		"Remember: 80% of the code you write today may be unreadable in 6 months, even by you."
		"Take regular breaks! Your code, and your health, will thank you."
		"Don't over-optimize prematurely. Solve the problem first, improve later."
		"Write tests! A bug found during testing is much better than one found in production."
		"A clean codebase is a happy codebase. Refactor often."
		"Why did the programmer quit their job? They didn’t get arrays."
		"Debugging is like being the detective in a crime movie where you are also the murderer."
	)
	echo "${tips[$((RANDOM % ${#tips[@]}))]}"
}

# Fetch the weather for the provided location
function fetch_weather {
	location="${1:-Pune}" # Default to "New York" if no location is provided
	weather=$(curl -s "https://wttr.in/$location?format=3")
	echo "Weather in $weather"
}

# Display the current date and time
function display_datetime {
	echo "Today is $(date '+%A, %B %d, %Y'), and the current time is $(date '+%H:%M:%S')."
}

# Main script output
echo "🌅 Welcome, Developer! Here’s your Daily Dev Tip 🌅"
display_datetime
echo
echo "🌤️ $(fetch_weather "$1")"
echo
echo "💡 Dev Tip of the Day:"
fetch_dev_tip
echo
echo "💻 Happy Coding!"
