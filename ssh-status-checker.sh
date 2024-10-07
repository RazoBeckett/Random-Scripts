#!/bin/env sh

HOST=$1
PORT="${2:-22}"

if [ -z "$HOST" ]; then
	echo "Usage: $0 <hostname/ip> [port]"
	exit 1
fi

echo "$PORT"

if ssh -p "$PORT" -o BatchMode=yes -o ConnectTimeout=5 "$HOST" exit 2>/dev/null; then
	echo "SSH is accessible on $HOST:$PORT"
else
	echo "SSH is not accessible on $HOST:$PORT"
fi
