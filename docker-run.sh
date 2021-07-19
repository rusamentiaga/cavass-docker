#!/usr/bin/env bash

if [ $# -eq 0 ]; then
	echo "Running bash"
    ARGS=bash
else
    ARGS="$@"
fi

USER_IDS=(-e BUILDER_UID="$( id -u )" -e BUILDER_GID="$( id -g )" -e BUILDER_USER="$( id -un )" -e BUILDER_GROUP="$( id -gn )")

docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	-v "/home/$USER:/home/$USER" -it --rm "${USER_IDS[@]}" cavass:1.0.25 /opt/cavass-build/cavass
