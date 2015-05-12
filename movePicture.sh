#!/bin/bash

# This help move picture to the folder named by creating date.

MP_SOURCE=$PWD
MP_TARGET=$PWD

# Do copy istead of move
MP_COPY_MODE=0

while getopts "cs:t:h" name
do
    case $name in
    "c")
        MP_COPY_MODE=1
        ;;
    "s")
        if ! [[ -d "$OPTARG" ]] ; then
            echo "error: -s need a source folder" >&2
            exit 1
        else
            MP_SOURCE="$OPTARG"
        fi
	    ;;
    "t")
        if ! [[ -d "$OPTARG" ]] ; then
            echo "error: -t need a folder" >&2
            exit 1
        else
            MP_TARGET="$OPTARG"
        fi
	    ;;
	"h")
	    echo "movePicture.sh <source folder> <target folder>"
	    echo "movePicture will create named-by-date folder in <target folder>."
	    echo "And move picture in <source folder> to <target folder>."
	    exit 1
	    ;;
    esac
done

echo "Source: $MP_SOURCE"
echo "Target: $MP_TARGET"

for pic in $(find "$MP_SOURCE" -maxdepth 1 -type f)
do
    echo found $pic
    folder_name=`exiftool -t -d "%Y_%m_%d" -createDate $pic | cut -f 2`
    if ! [ -d "$MP_TARGET/$folder_name" ]; then
        mkdir "$MP_TARGET/$folder_name"
    fi
    if [ "$folder_name" == "" ]; then
        echo "$pic" not an image.
    else
        if [ $MP_COPY_MODE -eq 1 ]; then
            cp -i $pic "$MP_TARGET/$folder_name/"
        else
            mv -i $pic "$MP_TARGET/$folder_name/"
        fi
    fi
done



