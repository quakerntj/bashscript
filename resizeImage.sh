#!/bin/bash
ResizeIMGS_Width=1440
ResizeIMGS_Output_Dir=""
ResizeIMG_SameFileName=0

function gcd() {
    local x=0
    local y=0
    if [ $1 -gt $2 ]; then
        x=$1
        y=$2
    else
        y=$1
        x=$2
    fi
    if [ $((x % y)) -eq 0 ] ; then
        return $y
    else
        gcd $y $(($x % $y))
        return $?
    fi
}

while getopts "w:m:o:s" name
do
    case $name in
    "w")
        if [[ $ResizeIMGS_MIsSetted -eq 1 ]]; then
            echo "should not set -w -m together"
            exit 1
        fi
        if ! [[ $OPTARG =~ ^[1-9][0-9]+$ ]] ; then
            echo "error: -w need a number" >&2
            exit 1
        else
            ResizeIMGS_Width=$OPTARG
        fi
        ResizeIMGS_WIsSetted=1
	    ;;
    "m")
        if [[ $ResizeIMGS_WIsSetted -eq 1 ]]; then
            echo "should not set -w -m together"
            exit 1
        fi
        if [ "$OPTARG" == "1" ]; then
    	    ResizeIMGS_Width=1440
    	    echo "1440 family"
    	elif [ "$OPTARG" == "2" ]; then
        	ResizeIMGS_Width=1920
    	    echo "1920 family"
    	elif [ "$OPTARG" == "3" ]; then
        	ResizeIMGS_Width=2160
    	    echo "2160 family"
    	else
    	    echo "-w [1|2|3]"
    	    exit 1
	    fi
	    ResizeIMGS_MIsSetted=1
	    ;;
    "o")
        if [ -d "$OPTARG" ] ; then
            ResizeIMGS_Output_Dir="$OPTARG"
        else
            echo "Folder \"$OPTARG\" not exist"
            exit 1
        fi
        ;;
    "s")
        ResizeIMG_SameFileName=1
    esac
done

if [ $# -ne 0 ]; then
    ResizeIMGS=$@
else
    if [ "$(uname)" == "Linux" ]; then
        ResizeIMGS=$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
        echo "Patch mode"
    else
        echo "not supported OS"
        exit 1
    fi
fi

for ResizeIMG in $ResizeIMGS
do
    if [ ! -f $ResizeIMG ]; then
        #echo "$ResizeIMG not exist"
        continue
    fi
    dir_name=$(dirname $ResizeIMG)
    ext_name="${ResizeIMG##*.}"
    file_name=$(basename "$ResizeIMG" ".$ext_name")

    ResizeIMG_X=`exiftool -t -ImageSize $ResizeIMG  | cut -f 2 | cut -d "x" -f 1`
    ResizeIMG_Y=`exiftool -t -ImageSize $ResizeIMG  | cut -f 2 | cut -d "x" -f 2`
    echo Origin:    $ResizeIMG_X"x"$ResizeIMG_Y
    ResizeRotation=0
    if [ $ResizeIMG_X -lt $ResizeIMG_Y ]; then
        echo "rotated"
        ResizeTMP=$ResizeIMG_X
        ResizeIMG_X=$ResizeIMG_Y
        ResizeIMG_Y=$ResizeTMP
        ResizeRotation=1
    fi
    ResizeIMG_Width=$ResizeIMGS_Width
    if [ $((ResizeIMG_X*3/500)) == $((ResizeIMG_Y*4/500)) ]; then
        ResizeIMG_Aspect="4:3"
        ResizeIMG_Height=$((ResizeIMGS_Width/4*3))
    elif [ $((ResizeIMG_X*2/500)) == $((ResizeIMG_Y*3/500)) ]; then
        ResizeIMG_Aspect="3:2"
        ResizeIMG_Height=$((ResizeIMGS_Width/3*2))
    elif [ $((ResizeIMG_X*9/500)) == $((ResizeIMG_Y*16/500)) ]; then
        ResizeIMG_Aspect="16:9"
        ResizeIMG_Height=$((ResizeIMGS_Width/16*9))
    elif [ $((ResizeIMG_X*10/500)) == $((ResizeIMG_Y*16/500)) ]; then
        ResizeIMG_Aspect="16:10"
        ResizeIMG_Height=$((ResizeIMGS_Width/16*10))
    else
        gcd $ResizeIMG_X $ResizeIMG_Y
        GCD=$?
        if [[ $GCD -eq 0 ]]; then
            ResizeIMG_Aspect="Unknow $ResizeIMG_X:$ResizeIMG_Y"
        else
            ResizeIMG_Aspect="Unknow ("$((ResizeIMG_X/GCD))":"$((ResizeIMG_Y/GCD))")="$((ResizeIMG_X*10/ResizeIMG_Y))"/10"
        fi
        ResizeIMG_Height=$((ResizeIMGS_Width/4*3))
    fi
    if [ $ResizeRotation -eq 1 ]; then
        ResizeTMP=$ResizeIMG_X
        ResizeIMG_X=$ResizeIMG_Y
        ResizeIMG_Y=$ResizeTMP
        ResizeTMP=$ResizeIMG_Width
        ResizeIMG_Width=$ResizeIMG_Height
        ResizeIMG_Height=$ResizeTMP
    fi

    if [ $ResizeIMG_SameFileName -eq 1 ]; then
        ResizeIMG_Output_Name=$file_name.$ext_name
    else
        ResizeIMG_Output_Name=$file_name.$ResizeIMG_Width.$ext_name
    fi

    if [ "$ResizeIMGS_Output_Dir" != "" ]; then
        ResizeIMG_Output="$ResizeIMGS_Output_Dir/$ResizeIMG_Output_Name"
    else
        ResizeIMG_Output="$dir_name/$ResizeIMG_Output_Name"
    fi

    echo "$ResizeIMG -> $ResizeIMG_Output"
    echo Aspect rate:   $ResizeIMG_Aspect
    echo convert to:    "$ResizeIMG_Width"x"$ResizeIMG_Height"


    if [ $ResizeIMG_X -gt $ResizeIMG_Width ]; then
        convert $ResizeIMG -quality 98 -resize "$ResizeIMG_Width"x"$ResizeIMG_Height" "$ResizeIMG_Output"
    else
        convert $ResizeIMG -quality 98 -sample "$ResizeIMG_Width"x"$ResizeIMG_Height" "$ResizeIMG_Output"
        echo "Enlarge!"
    fi
    echo
done
