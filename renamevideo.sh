#!/bin/bash

function nameVideoByDate() {
    echo
    dir_name=$(dirname $1)
    file_name=$(basename "$1")
    ext_name="${file_name##*.}"

    avprobe -v quiet $1
    err=$?
    if [ $err -gt 0 ]; then
        echo "Error when avprobe ($err)"
        return $err;
    fi
    creation_time=`avprobe $1 2>&1 | grep -m 1 creation_time | sed 's/.*: \([0-9 -:]*\).*/\1/g'`
    if [ "$creation_time" == "" ]; then
        return -1;
    fi
    new_name=`date -d "$creation_time" +%Y%m%d_%H%M%S`
    if [ "$new_name" == "" ]; then
        echo "Date formating fail \"$creation_time\""
        return -1;
    fi
    new_name="$dir_name/$new_name.$ext_name"
    echo "rename $file_name -> $new_name"
    mv -i $1 $new_name
}


if [ -d "$1" ]; then 
    for v in $(find "$1" -maxdepth 1 -type f)
    do
        echo found $v
        nameVideoByDate $v
    done
else
    nameVideoByDate $1
fi


