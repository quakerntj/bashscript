#!/bin/bash
qa > /dev/null
INCLUDE_PATH=
INCLUDE_PATH_COMMON="common/frameworks/base/include"
INCLUDE_PATH_GAIA="frameworks_gaia/base/include/gaiainternal"
INCLUDE_PATH_SDK="sdk/include/gaia"

#Because using source, need reset OPTIND to 1 for variable parse.
OPTIND=1

while getopts "cgs" WHICH_INC
do
	echo $WHICH_INC
	case $WHICH_INC in 
	c)
		INCLUDE_PATH="$INCLUDE_PATH_COMMON"
		break;;
	g)
		INCLUDE_PATH="$INCLUDE_PATH_GAIA"
		break;;
	s)
		INCLUDE_PATH="$INCLUDE_PATH_SDK"
		break;;
	?)
		echo "Syntax: inc -c/g/s"
		break;;
	esac
done

if [ "$INCLUDE_PATH" != "" ]; then

	if [ -d "$INCLUDE_PATH" ]; then
		cd $INCLUDE_PATH
		if [ $# -gt 1 ]; then
			echo $@
			$@
		fi
	else
		echo "Cant find $INCLUDE_PATH"
	fi
else
	pushd > /dev/null
fi

