#!/bin/bash
G_TOP=$TOP
if [ "$TOP" != "" ] ; then
	G_TOP="~/w/device"
fi

G_PATH=$(eval echo "$G_TOP/$1")
if [[ -d $G_PATH ]]; then
	qa > /dev/null
	echo "cd $G_PATH"
	cd $G_PATH
elif [[ -f $G_PATH ]]; then
	qa > /dev/null
	echo "gedit $G_PATH"
	G_DIRNAME=`dirname $G_PATH`
	cd $G_DIRNAME
	gedit $G_PATH
else
	qa > /dev/null
	case $1 in
		"wrapper" | "w")
			eval cd $G_TOP/sdk/wrapper;;
		"frameworks_gaia" | "fg")
			eval cd $G_TOP/frameworks_gaia;;
		"core" | "c")
			eval cd $G_TOP/frameworks_gaia/gaiacore;;
		"per" | "p")
			eval cd $G_TOP/frameworks_gaia/gaiaper;;
		"gaiaframework" | "gf")
			eval cd $G_TOP/frameworks_gaia/gaiaframework;;
		"nio" | "n")
			eval cd $G_TOP/frameworks_gaia/nio;;
		"base" | "b")
			eval cd $G_TOP/frameworks_gaia/base;;
		"Tests" | "T")
			eval cd $G_TOP/sdk/Tests;;
		"example" | "e")
			eval cd $G_TOP/sdk/example;;
		"bsp")
			eval cd $G_TOP/bsp;;
	#		eval cd $G_TOP/;;
	esac
	if [[ $# -ge 2 ]]; then
		shift
		eval $@
	fi
fi
