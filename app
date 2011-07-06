#!/bin/bash
ga

cd packages/apps/MultiColorBlur/src/com/htc/gaia/service/wallpaper
if [ $# -gt 1 ]; then
	echo $@
	$@
fi
