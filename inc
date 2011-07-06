#!/bin/bash
ga
INCLUDE_PATH=
if [ -d ../common ]; then
	INCLUDE_PATH=frameworks_gaia/base/include/gaia
else
	INCLUDE_PATH=frameworks/base/include/
fi

cd $INCLUDE_PATH
if [ $# -gt 1 ]; then
	echo $@
	$@
fi

