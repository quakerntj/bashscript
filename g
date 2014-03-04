#!/bin/bash
G_TOP=$TOP
if [ "$TOP" == "" ] ; then
	G_TOP="~/w/device"
fi

#G_OPTION_GODIR_BY_DIR=0
#G_OPTION_GODIR_BY_FILE=0
#while getopts "dgh" G_OPTION
#do
#	echo $G_OPTION
#	case $G_OPTION in 
#	d)
#		G_OPTION_GODIR_BY_DIR=1;
#		break;;
#	g)
#		G_OPTION_GODIR_BY_FILE=1;
#		break;;
#	h)
#		echo "Syntax:";
#		echo "    gotodir g -d <dirname pattern>";
#		echo "    gotodir g -g <filename pattern>";
#		break;;
#	esac
#done

if [[ "$1" != "" ]] ; then

G_PATH=$(eval echo "$G_TOP/$1")
# change :123: to :123
G_COMBINED_PATH=`echo $1 | sed 's/\(:[0-9]\+\):.*/\1 /g'`
#echo G_COMBINED_PATH = $G_COMBINED_PATH
G_COMBINED_LINE=`echo $G_COMBINED_PATH | sed 's/\(.*\):\([:number:]\+\)/\2/g' | grep -o "[0-9]\+"`
G_COMBINED_PATH=`echo $G_COMBINED_PATH | sed 's/\([^:]*\)\:.*/\1/g'`

#echo G_COMBINED_LINE = $G_COMBINED_LINE
#echo G_COMBINED_PATH = $G_COMBINED_PATH

G_PATH2=$(eval echo "$G_TOP/$G_COMBINED_PATH")
G_GEDIT_PROFILE="~/bashscript/.geditor_openlist"

if [[ "$G_COMBINED_LINE" == "" ]]; then
	G_COMBINED_LINE=0
fi

if [[ -d $G_PATH ]]; then
	qa > /dev/null
	echo "cd $G_PATH"
	cd $G_PATH
elif [[ -f "$G_PATH" ]]; then
	qa > /dev/null
	echo "gedit $G_PATH"
	G_DIRNAME=`dirname $G_PATH`
	gedit $G_PATH
elif [[ -f "$G_COMBINED_PATH" ]]; then
	echo "gedit $G_COMBINED_PATH +$G_COMBINED_LINE"
	G_DIRNAME=`dirname $G_COMBINED_PATH`
	eval gedit "$G_COMBINED_PATH +$G_COMBINED_LINE"
elif [[ -f "$G_PATH2" ]]; then
	echo "gedit $G_PATH2 +$G_COMBINED_LINE"
	G_DIRNAME=`dirname $G_COMBINED_PATH`
	eval gedit "$G_PATH2 +$G_COMBINED_LINE"
elif [[ "$1" == "P" ]] ; then
	GG_PROFILE=`eval echo $G_GEDIT_PROFILE.$2`
	if [[ $(eval test -f $G_GEDIT_PROFILE.$2) -eq 0 ]]; then
		GG_LIST=
		GG_TITLE="\"Choose file of profile $2\""
		GG_C1_TITLE="\"\""
		GG_C2_TITLE="\"\""
		GG_C3_TITLE="File"
		GG_SEPERATOR="\" \""

		while read GG_LINE
		do
			GG_CHECKED=$(echo $GG_LINE | cut -f1 -s -d,;)
			GG_FILENAME=$(echo $GG_LINE | cut -f2 -s -d,;)
			GG_BASENAME=$(echo $GG_LINE | cut -f3 -s -d,;)

			if [[ "$GG_CHECKED" == "" ]]; then
				continue;
			fi
			if [[ ! -f "$GG_FILENAME" ]]; then
				continue;
			fi
			if [[ "$GG_BASENAME" == "" ]]; then
				GG_BASENAME=$(basename $GG_FILENAME)
			fi
			GG_LIST="$GG_LIST $GG_CHECKED $GG_FILENAME \"$GG_BASENAME\""
		done < "$GG_PROFILE"

		if [[ "$GG_LIST" != "" ]]; then
			eval GG_OPEN=$(eval zenity --list --separator=$GG_SEPERATOR \
				--hide-column=2 --checklist --text=$GG_TITLE \
				--column $GG_C1_TITLE --column $GG_C2_TITLE \
				--column $GG_C3_TITLE $GG_LIST)
			if [[ "$GG_OPEN" != "" ]]; then
				gedit $GG_OPEN
			fi
		else
			echo empty
		fi
	else
		echo "$G_GEDIT_PROFILE.$2 $GG_PROFILE not exist"
	fi
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
	*)
		ONE_GODIR_FILE=`one_godir $G_COMBINED_PATH`
		if [[ -f "$ONE_GODIR_FILE" ]]; then
			echo gedit $ONE_GODIR_FILE +$G_COMBINED_LINE
			gedit $ONE_GODIR_FILE +$G_COMBINED_LINE
			popd > /dev/null
		else
			echo "    godir $ONE_GODIR_FILE"
			echo ""
			echo "    w fg c p gf n b T e"
			echo "    <uniqe file name>"
			echo "    path/file:linenumber"
			echo "    P profile"
			popd > /dev/null
		fi;;
	esac
	if [[ $# -ge 2 ]]; then
		shift
		eval $@
	fi
fi

# $1 != NULL
fi
