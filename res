#!/bin/bash
ga
FRAMEWORKS_PATH=
if [ -d ../common ]; then
	FRAMEWORKS_PATH=frameworks_gaia
else
	FRAMEWORKS_PATH=frameworks
fi

cd $FRAMEWORKS_PATH/base/core/java/android/content/res
if [ $# -gt 1 ]; then
	echo $@
	$@
fi
