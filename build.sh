#!/bin/sh

SCRIPT=$(readlink -f "$0" 2>/dev/null || python -c 'import os,sys;print os.path.realpath(sys.argv[1])' "$0" 2>/dev/null)
[ -f "$SCRIPT" ] || { echo "Cannot locate this script (looks like it's \"$SCRIPT\")"; exit 1; }

SCRIPT_DIR=$(dirname "$SCRIPT")
[ -d "$SCRIPT_DIR" ] || { echo "Cannot locate this script (looks like it's in \"$SCRIPT_DIR\")"; exit 1; }

cd "$SCRIPT_DIR"

# Configuration parameters
BUILD_AS_USER=${BUILD_AS_USER:-$(id -u)}
BUILD_AS_GROUP=${BUILD_AS_GROUP:-$(id -g)}

docker build \
	--build-arg build_as_user="$BUILD_AS_USER" \
	--build-arg build_as_group="$BUILD_AS_GROUP" \
	"$@" \
	.
